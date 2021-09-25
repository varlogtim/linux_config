import json
import re
import os
import subprocess
import sys
import time
import uuid
import shutil
from typing import Callable, List, Tuple
from contextlib import contextmanager
from requests.exceptions import (ConnectionError, HTTPError)

import boto3
import requests


TENSORBOARD_TRIGGER_READY_MSG = "TensorBoard contains metrics"


def set_s3_region(bucket: str) -> None:
    endpoint_url = os.environ.get("DET_S3_ENDPOINT", None)

    client = boto3.client("s3", endpoint_url=endpoint_url)
    bucketLocation = client.get_bucket_location(Bucket=bucket)

    region = bucketLocation["LocationConstraint"]

    if region is not None:
        # We have observed that in US-EAST-1 the region comes back as None
        # and if AWS_REGION is set to None, tensorboard fails to pull events.
        print(f"Setting AWS_REGION environment variable to {region}.")
        os.environ["AWS_REGION"] = str(region)


def wait_for_tensorboard(max_seconds: float, url: str, still_alive_fn: Callable[[], bool]) -> bool:
    """Return True if the process successfully comes up before a deadline."""

    deadline = time.time() + max_seconds

    while True:
        if time.time() > deadline:
            print(f"TensorBoard did not find metrics within {max_seconds} seconds", file=sys.stderr)
            return False

        if not still_alive_fn():
            print("TensorBoard process died before reporting metrics", file=sys.stderr)
            return False

        time.sleep(1)

        try:
            res = requests.get(url)
            res.raise_for_status()
        except (requests.exceptions.ConnectionError, requests.exceptions.HTTPError):
            continue

        try:
            tags = res.json()
        except ValueError:
            continue

        # TensorBoard will return { trial/<id> : { tag: value } } when data is present.
        if len(tags) == 0:
            print("TensorBoard is awaiting metrics...")
            continue

        for val in tags.values():
            if len(val):
                print("TensorBoard contains metrics")
                return True


def main(args: List[str]) -> int:
    with open("/run/determined/workdir/experiment_config.json") as f:
        exp_conf = json.load(f)

    print(f"TTUCKER exp_conf: {exp_conf}")

    if exp_conf["checkpoint_storage"]["type"] == "s3":
        set_s3_region(exp_conf["checkpoint_storage"]["bucket"])

    url = get_tensorboard_url()
    tensorboard_args = get_tensorboard_args(args)

    print(f"Running: {tensorboard_args}")
    p = subprocess.Popen(tensorboard_args)

    def still_alive() -> bool:
        return p.poll() is None

    if not wait_for_tensorboard(600, url, still_alive):
        p.kill()

    return p.wait()


def get_tensorboard_version(version: str) -> Tuple[str, str]:
    """
    Gets the version of the tensorboard package currently installed. Used
    by downstream processes to determine args passed in.
    :return: version in the form of (major, minor) tuple
    """
    major, minor, _ = version.split(".")

    return major, minor


def get_tensorboard_args(args: List[str]) -> List[str]:
    """
    Builds tensorboard startup args from args passed in from tensorboard-entrypoint.sh
    Args are added and deprecated at the mercy of tensorboard; all of the below are necessary to
    support versions 1.14, 2.4, and 2.5

    - If multiple directories are specified and the tensorboard version is > 1,
    use legacy logdir_spec behavior

    - Tensorboard 2+ no longer exposes all ports. Must pass in "--bind_all" to expose localhost

    - Tensorboard 2.5.0 introduces an experimental feature (default load_fast=true)
    which prevents multiple plugins from loading correctly.
    """
    task_id = os.environ["DET_TASK_ID"]
    port = os.environ["TENSORBOARD_PORT"]

    version = args.pop(0)

    # logdir is the second argument passed in from tensorboard_manager.go. If multiple directories
    # are specified and the tensorboard version is > 1, use legacy logdir_spec behavior. NOTE:
    # legacy logdir_spec behavior is not supported by many tensorboard plugins
    logdir = args.pop(0)

    tensorboard_args = ["tensorboard", f"--port={port}", f"--path_prefix=/proxy/{task_id}", *args]

    tensorboard_args.append("-v 9")

    major, minor = get_tensorboard_version(version)

    if major == "2":
        tensorboard_args.append("--bind_all")
        if minor == "5":
            tensorboard_args.append("--load_fast=false")
        if len(logdir.split(",")) > 1:
            tensorboard_args.append(f"--logdir_spec={logdir}")
            return tensorboard_args

    tensorboard_args.append(f"--logdir={logdir}")
    return tensorboard_args



#
#
#
#
#
#
#


@contextmanager
def tfevents_dir():
    # XXX Not needed as container will wipe?
    try:
        script_dir = os.path.dirname(__file__)
        temp_dir = os.path.join(script_dir, f"tb_events_{str(uuid.uuid4())}")
        os.makedirs(temp_dir, mode=0o777, exist_ok=True)
        yield temp_dir
    finally:
        try:
            shutil.rmtree(temp_dir)
        except Exception:
            pass


class S3Connector:
    def __init__(self, storage_config):
        req_keys = ["bucket", "access_key", "secret_key", "endpoint_url"]
        for key in req_keys:
            try:
                storage_config[key]
            except KeyError:
                raise ValueError(f"storage_config must define a '{key}'")

        self.client = boto3.client(
            "s3",
            endpoint_url=storage_config["endpoint_url"],
            aws_access_key_id=storage_config["access_key"],
            aws_secret_access_key=storage_config["secret_key"],
        )
        # XXX validate client.

        self.bucket = storage_config["bucket"]  # XXX ???
        self.delimiter = "/"
        self.s3_path_regex = re.compile(
            r"^s3://(?P<bucket>[^/]+)/(?P<key>.+)$"
        )

    def _path_to_bucket_key(self, s3_path):
        m = re.match(self.s3_path_regex, s3_path)
        if m is None:
            raise ValueError(f"{s3_path} does not match")  # XXX Fix me
        return m.group("bucket"), m.group("key")

    def storage_to_local(self, s3_path, local_path, make_dirs=True):
        bucket, key = self._path_to_bucket_key(s3_path)

        get_obj_args = {"Bucket": bucket, "Key": key}
        resp = self.client.get_object(**get_obj_args)

        if make_dirs:
            dir_path = os.path.dirname(local_path)
            os.makedirs(dir_path, exist_ok=True)

        body = resp.get("Body", None)
        if body is None:
            raise ValueError("Could not find Body in response")

        with open(local_path, "wb+") as file:
            while file.write(body.read(amt=2 ** 20)):
                pass

        print(f"DEBUG: wrote file: {local_path}")

    def local_to_storage(self, local_path, s3_path):
        bucket, key = self._path_to_bucket_key(s3_path)
        raise NotImplementedError("Impl me")

    def list_files(self, s3_path, recursive=True):
        # Generates tuples of (s3_key, datetime.datetime)
        bucket, key = self._path_to_bucket_key(s3_path)

        list_args = {"Bucket": bucket, "Prefix": key}
        if not recursive:
            list_args["Delimiter"] = self.delimiter

        # XXX Does not handle "directories", i.e., prefixes
        while True:
            list_dict = self.client.list_objects_v2(**list_args)

            for s3_obj in list_dict.get("Contents", []):
                yield (f"/{bucket}/{s3_obj['Key']}",
                       s3_obj["LastModified"])

            list_args.pop("ContinuationToken", None)
            if list_dict["IsTruncated"]:
                list_args["ContinuationToken"] = list_dict["NextContinuationToken"]
                continue

            break


def get_tensorboard_url():
    """Get Tensorboard URL from environment variables."""
    task_id = os.environ["DET_TASK_ID"]
    port = os.environ["TENSORBOARD_PORT"]
    tensorboard_addr = f"http://localhost:{port}/proxy/{task_id}"

    return f"{tensorboard_addr}/data/plugin/scalars/tags"


# XXX Possibly create an S3 Path type and conversions.

def get_tb_args(tb_version, tfevents_dir, add_args):
    """Build tensorboard startup args.

    Args are added and deprecated at the mercy of tensorboard; all of the below are necessary to
    support versions 1.14, 2.4, and 2.5

    - Tensorboard 2+ no longer exposes all ports. Must pass in "--bind_all" to expose localhost
    - Tensorboard 2.5.0 introduces an experimental feature (default load_fast=true)
    which prevents multiple plugins from loading correctly.
    """
    task_id = os.environ["DET_TASK_ID"]
    port = os.environ["TENSORBOARD_PORT"]

    tensorboard_args = [
        "tensorboard",
        f"--port={port}",
        f"--path_prefix=/proxy/{task_id}",
        *add_args
    ]

    # Version dependant args
    version_parts = tb_version.split(".")
    major = int(version_parts[0])
    minor = int(version_parts[1])

    bind_all = False
    load_fast = True

    if major >= 2:
        bind_all = True
    if major > 2 or major == 2 and minor >= 2:
        load_fast = False

    if bind_all:
        tensorboard_args.append("--bind_all")
    if not load_fast:
        tensorboard_args.append("--load_fast=false")

    tensorboard_args.append(f"--logdir={tfevents_dir}")

    return tensorboard_args


def ttucker_main(args):
    tb_version = args[0]
    paths = args[1].split(',')
    add_args = args[2:]


    #
    #
    #


    print(f"DEBUG: paths: {paths}")
    # Setup Storage Connector
    with open("/run/determined/workdir/experiment_config.json") as f:
        exp_conf = json.load(f)

    checkpoint_storage = exp_conf.get('checkpoint_storage', None)
    if checkpoint_storage is None:
        raise ValueError("chechpoint_storage not defined in config")

    print(f"DEBUG: checkpoint_storage: {checkpoint_storage}")

    storage_type = checkpoint_storage.get('type', None)
    if storage_type is None:
        raise ValueError("checkpoint_storage must define a 'type'")

    storage_connectors = {
        "s3": S3Connector,
        # XXX impl others.
    }

    if storage_type not in storage_connectors.keys():
        raise NotImplementedError(
            f"checkpoint_storage.type == {storage_type} not impl"
        )

    connector = storage_connectors[storage_type](checkpoint_storage)

    #
    # XXX rest should be in thread
    #

    tfevents_files = {}  # {filepath -> datetime}, update on iter

    # Check the paths
    with tfevents_dir() as temp_dir:
        # Can launch tensorboard here.
        tb_args = get_tb_args(tb_version, temp_dir, add_args)
        tb_process = subprocess.Popen(tb_args)
        print(f"DEBUG: tensorboard args: {tb_args}")

        tb_url = get_tensorboard_url()
        tb_has_metrics = False

        stop_time = time.time() + 600

        # XXX Is there an instance in which we start tensorboard
        # but there are no metrics available?

        print(f"DEBUG: temp_dir = {temp_dir}")

        for ii in range(100):
            files_to_download = []
            # Look at all the files
            for path in paths:
                for file, mtime in connector.list_files(path):
                    prev_mtime = tfevents_files.get(file, None)
                    if prev_mtime is not None and prev_mtime >= mtime:
                        print(f"DEBUG: we have the file: {file}")
                        continue
                    print(f"DEBUG: we don't have file: {file}")
                    files_to_download.append(file)
                    tfevents_files[file] = mtime
            # We checked the cache, let's download the new stuff.
            for file in files_to_download:
                print(f"DEBUG: temp_dir: {temp_dir}")
                local_path = os.path.join(temp_dir, file.lstrip('/'))
                print(f"DEBUG: local_path: {local_path}")
                connector.storage_to_local(f"s3:/{file}", local_path)

            # Check if TB process is alive
            ret_code = tb_process.poll()
            if ret_code is not None:
                return ret_code

            # Check if we have metrics:
            try:
                res = requests.get(tb_url)
                res.raise_for_status()
                print(f"DEBUG: Got an HTTP response from Tensorboard")
                tags = res.json()
                print(
                    f"DEBUG: Decoded the response from Tensorboard. "
                    f"res: {res}"
                )
                if len(tags) == 0:
                    msg = f"No metrics available, len(tags) == 0"
                    print(f"DEBUG: {msg}")
                    raise ValueError(msg)
                for val in tags.values():
                    if len(val):
                        tb_has_metrics = True
            except (ConnectionError, HTTPError, ValueError) as exp:
                print(f"DEBUG: exception in loop: {exp}")
                pass

            # XXX Use exceptions to report state.

            # Check if we have reached a timeout.
            if not tb_has_metrics and time.time() > stop_time:
                print(
                    f"DEBUG: reached timeout without getting metrics. "
                    f"Killing Tensorboard process"
                )
                tb_process.kill()
                return 1
            if tb_has_metrics:
                print(f"DEBUG: Tensorboard has metrics")
                print(TENSORBOARD_TRIGGER_READY_MSG)

            time.sleep(1)
            print(f"DEBUG: sleeping 1")
        # End Loop
    # exit temp_dir context


if __name__ == "__main__":
    my_args = sys.argv[1:]
    print(f"TTUCKER: __main__(): my_args: {my_args}")
    ret = ttucker_main(my_args)
    sys.exit(ret)
    # sys.exit(1)
    # sys.exit(main(sys.argv[1:]))

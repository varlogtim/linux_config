#!/bin/env python3
import os
import sys
import json
import shutil
import subprocess

from typing import Tuple


USAGE="""
Purpose:
  Get public IP of master instance.

Usage:
  {script_name} <cluster_id>

Dependencies:
  This script requires the 'awscli' package

""".format(script_name=sys.argv[0])

aws_bin = None

def init() -> None:
    global aws_bin
    try:
        aws_bin = shutil.which('aws')

        if aws_bin is None:
            raise RuntimeError(
                'Unable to find the "aws" binary. '
                'Please "pip install awscli" to resolve.'
            )
        if len(sys.argv) != 2:
            raise ValueError('Incorrect number of arguments')
    except Exception as e:
        sys.stderr.write('{e}')
        print(USAGE)
        sys.exit(1)


def describe_instances() -> dict:
    desc_instances_args = [aws_bin, "ec2", "describe-instances"]

    p = subprocess.Popen(
        desc_instances_args,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE)
    # XXX check return code
    out, err = p.communicate()
    try:
        instances = json.loads(out)
        return instances
    except Exception:
        # XXX handle this better
        raise

def find_instance(desc_instances: dict, cluster_id: str) -> str:
    from pprint import pprint

    for res in desc_instances["Reservations"]:
        for instance in res["Instances"]:
            tags = instance.get("Tags", None)
            if tags is None:
                continue
            for tag in instance["Tags"]:
                found_inst = False
                # print(f"KEY: {tag['Key']}")
                # print(f"VAL: {tag['Value']}")
                if tag["Key"] == "aws:cloudformation:stack-name":
                    if tag["Value"] == cluster_id:
                        found_inst = True
                        break
            if found_inst:
                pub_ip = None
                for interface in instance["NetworkInterfaces"]:
                    assoc = interface.get("Association", None)
                    if assoc is None:
                        continue
                    pub_ip = assoc.get("PublicIp", None)

                if pub_ip is None:
                    print(f"Could not find public IP of {cluster_id}")
                else:
                    print(f"export DET_MASTER={pub_ip}")
            
if __name__ == "__main__":
    init()
    cluster_id = sys.argv[1]
    desc_instances = describe_instances()
    find_instance(desc_instances, cluster_id)


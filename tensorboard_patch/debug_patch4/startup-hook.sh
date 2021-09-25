#!/bin/bash

# For determined version 0.16.5 ???

# Force Tensorboard 2.5.0 (XXX REMOVE ME)
# pushd /tmp/tensorboard/tensorboard/pip_package/
# pip install -e .
# popd
# pip install tensorboard==2.5.0

# Patch for Lockheed to set AWS vars correctly.

declare -A PACKAGE_MAP

GET_FILE_PATH_PYTHON="import %s; print(%s.__file__);"

# [<file_name_in_model_dir>]=<python_include_path>
PACKAGE_MAP[tensorboard_debug.py]="determined.exec.tensorboard"
# PACKAGE_MAP[io_wrapper.py]="tensorboard.backend.event_processing.io_wrapper"
# PACKAGE_MAP[plugin_event_multiplexer.py]="tensorboard.backend.event_processing.plugin_event_multiplexer"
# PACKAGE_MAP[data_ingester.py]="tensorboard.backend.event_processing.data_ingester"
# ^ Append more packages as needed.


# Figure out the file paths to each of the packages:
for pfile in "${!PACKAGE_MAP[@]}"
do
    printf -v GET_PATH "$GET_FILE_PATH_PYTHON" \
        ${PACKAGE_MAP[$pfile]} ${PACKAGE_MAP[$pfile]}
    CUR_PATH=$(python3 -c "$GET_PATH") || echo ""
    if [ -n "$CUR_PATH" ]; then
        # Copy file over if we successfully found the path
        cp -v "$pfile" "$CUR_PATH"
    else
        echo "Couldn't find file path for ${PACKAGE_MAP[$pfile]}"
    fi
done


# Set environment vars:
# set +x
# export AWS_ACCESS_KEY_ID="AKIAROMVLJE2WJ6FD7DX"
# export AWS_SECRET_ACCESS_KEY="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"
# echo "set AWS_SECRET_ACCESS_KEY and AWS_ACCESS_KEY_ID"
# set -x
# export AWS_REGION="us-gov-east-1"
# export S3_USE_HTTPS="1"
# export S3_VERIFY_SSL="0"
# export S3_ENDPOINT="s3.${AWS_REGION}.amazonaws.com"

# if [ $S3_USE_HTTPS == "1" ]; then
#     DET_S3_ENDPOINT="https://${S3_ENDPOINT}"
# else
#     DET_S3_ENDPOINT="http://${S3_ENDPOINT}"
# fi
# export DET_S3_ENDPOINT

# export S3_CONNECT_TIMEOUT_MSEC=5000
# export S3_REQUEST_TIMEOUT_MSEC=5000
# export S3_CA_FILE="/path/to/somewhere"
# export S3_CA_PATH="/path/to/somewhere"

# To include AWS config file parameters which will be used with Tensorboard
# to connect with AWS S3 services.
#
# DET_AWS_CFG_<config_entry>
#
# See: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html#cli-configure-files-global
# export DET_AWS_CFG_region=$AWS_REGION

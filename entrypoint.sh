#!/bin/sh -l

# Copyright (c) Ercin Dedeoglu <e.dedeoglu@gmail.com>. All rights reserved.
# https://github.com/ErcinDedeoglu/ftp-transfer-action
#
# Licensed under the MIT License.

# Fail script on any error
set -e

# Validate Required Inputs
if [ -z "$INPUT_HOST" ]; then
  echo "Input host is required."
  exit 1
fi

if [ -z "$INPUT_USER" ]; then
  echo "Input user is required."
  exit 1
fi

if [ -z "$INPUT_PASSWORD" ]; then
  echo "Input password is required."
  exit 1
fi

# Initialize SSL Option
SSL_OPTION=""
if [ "$INPUT_FORCESSL" = "true" ]; then
  SSL_OPTION="set ftp:ssl-force true; set ssl:verify-certificate true;"
else
  SSL_OPTION="set ftp:ssl-force false; set ssl:verify-certificate false;"
fi

# FTP Transfer
lftp $INPUT_HOST -u "$INPUT_USER","$INPUT_PASSWORD" -e "
$SSL_OPTION
mirror $INPUT_OPTIONS --reverse --continue --dereference -x ^\.git/$ "$INPUT_LOCALDIR" "$INPUT_REMOTEDIR";
quit
"

# Check if lftp exited with a non-zero status
status=$?
if [ $status -ne 0 ]; then
  echo "FTP transfer failed with status $status"
  exit $status
else
  echo "FTP transfer completed successfully."
fi
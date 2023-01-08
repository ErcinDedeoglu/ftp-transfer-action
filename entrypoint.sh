#!/bin/sh -l

# Copyright (c) Ercin Dedeoglu <e.dedeoglu@gmail.com>. All rights reserved.
# https://github.com/ErcinDedeoglu/ftp-transfer-action
#
# Licensed under the MIT License.

lftp $INPUT_HOST -u $INPUT_USER,$INPUT_PASSWORD -e "set ftp:ssl-force $INPUT_FORCESSL; set ssl:verify-certificate false; mirror $INPUT_OPTIONS --reverse --continue --dereference -x ^\.git/$ $INPUT_LOCALDIR $INPUT_REMOTEDIR; quit"

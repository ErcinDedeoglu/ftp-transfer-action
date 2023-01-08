# Copyright (c) Ercin Dedeoglu <e.dedeoglu@gmail.com>. All rights reserved.
# https://github.com/ErcinDedeoglu/ftp-transfer-action
#
# Licensed under the MIT License.

FROM alpine:3.16

COPY LICENSE README.md /

RUN apk --no-cache add lftp

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

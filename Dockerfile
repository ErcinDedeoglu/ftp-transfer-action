# Copyright (c) Ercin Dedeoglu <e.dedeoglu@gmail.com>. All rights reserved.
# https://github.com/ErcinDedeoglu/ftp-transfer-action
#
# Licensed under the MIT License.

FROM alpine:3.16

# Metadata as recommended at http://label-schema.org
LABEL maintainer="Ercin Dedeoglu <e.dedeoglu@gmail.com>" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.name="FTP Transfer Action" \
      org.label-schema.description="This image is used to transfer files via FTP for GitHub Actions." \
      org.label-schema.url="https://github.com/ErcinDedeoglu/ftp-transfer-action"

# Install lftp and create a non-root user
RUN apk --no-cache add lftp && \
    adduser -D -u 1001 ftpuser

# Copy necessary files
COPY LICENSE README.md /
COPY entrypoint.sh /entrypoint.sh

# Change to non-root user
USER ftpuser

# Set necessary file permissions
RUN chmod +x /entrypoint.sh

# Set the entrypoint script to be executable
ENTRYPOINT ["/entrypoint.sh"]
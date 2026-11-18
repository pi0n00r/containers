#!/bin/bash
set -euo pipefail

curr_dir="$1"
VERSION=$(grep "FROM nextcloud:" "$curr_dir"/Dockerfile | cut -d ':' -f2 | cut -d '@' -f1)

# Generate a build id from relative file names and content. Absolute or
# caller-relative source paths must not change the resulting image tag.
build_id=$(
  cd "$curr_dir"
  find . -type f -exec sha256sum {} \; | LC_ALL=C sort | sha256sum | cut -d ' ' -f1
)
# Truncate the build id to 8 characters
build_id=${build_id:0:8}
echo "$VERSION-$build_id"

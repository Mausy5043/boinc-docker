#!/bin/bash

tag=$1

# Find out where we're running from
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -f Dockerfile ]; then
  echo "Not allowed. First execute:"
  echo "cd ${SCRIPT_DIR}"
  echo " Then try again."
  exit 1
fi

# build a local image
docker build -t "mausy5043/boinc:${tag}" .

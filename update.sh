#!/bin/bash

cmd="${1}"

# Find out where we're running from
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

git fetch origin master
git reset --hard FETCH_HEAD
git clean -df
git pull

if [ "${cmd}" == "--all" ]; then
  "${SCRIPT_DIR}"/build.sh local || exit 1
  "${SCRIPT_DIR}"/stop.sh || exit 1
  "${SCRIPT_DIR}"/run.sh local || exit 1
fi

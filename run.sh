#!/bin/bash

tag="$1"

# read MGR, USR and PSK parameters from local .config file
# shellcheck disable=SC1090
source "${HOME}/.config/docker/boinc.conf"

# Find out where we're running from
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -f Dockerfile ]; then
  echo "Not allowed. First execute:"
  echo "cd ${SCRIPT_DIR}"
  echo " Then try again."
  exit 1
fi

docker run -d \
  --name boinc \
  -h boinc \
  -v /srv/array1/config/configs/boinc/:/var/lib/boinc \
  -p 31416:31416 \
  -e BOINC_GUI_RPC_PASSWORD="123" \
  -e BOINC_CMD_LINE_OPTIONS="--allow_remote_gui_rpc" \
  mausy5043/boinc:"mausy5043/boinc:${tag}"

sleep 10

docker exec boinc boinccmd --join_acct_mgr "${MGR}" "${USR}" "${PSK}"

sleep 10

docker logs boinc

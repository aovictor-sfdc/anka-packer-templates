#!/bin/bash

vm_name="macos-gse-10.15"

if ! [[ $(anka show "$vm_name" status) == running ]]; then
  echo "vm not running."
  if anka show "$vm_name" status | grep -E '(suspended|stopped)'; then
    anka start "$vm_name" && echo "vm started"
  fi
else
  echo "vm is running already"
fi


echo "waiting a 30 seconds for machine to boot..."
sleep 30

VNCSTR=$(anka show "$vm_name" vnc_connection_string | awk -F\/\/ '{print $NF}')

echo "VNCSTR: $VNCSTR"

if which vncdo; then
  vncdo -s "${VNCSTR}" -p admin move 220 180 click 1 pause 2 \
    move 0 0 click 1 pause 2 \
    type "s" key enter pause 2 \
    type "profiles" pause 2 \
    key return pause 2 \
    key tab pause 2\
    key down pause 2\
    move 570 240 click 1 pause 2 \
    move 630 240 click 1
else
  echo "vncdo not installed"
  exit 1
fi

exit 0

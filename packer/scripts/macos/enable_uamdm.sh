#!/bin/bash

identifier='gse'
vm_name=$(anka list | grep -i "$identifier" | awk -F\| '{print $2}' | tr -d ' ')

if ! [[ $(anka show "$vm_name" status) == running ]]; then
  echo "vm not running."
  if anka show "$vm_name" status | grep -E suspended; then
    anka start "$vm_name" && echo "vm started from suspension"
    echo "waiting a 10 seconds for machine to boot..."
    sleep 10
  elif anka show "$vm_name" status | grep -E stopped; then
    anka start "$vm_name" && echo "vm started from stop"
    echo "waiting a 30 seconds for machine to boot..."
    sleep 30
  fi
else
  echo "vm is running already"
fi

VNCSTR=$(anka show "$vm_name" vnc_connection_string | awk -F\/\/ '{print $NF}')

echo "VNCSTR: $VNCSTR"

if which /Users/vao/.pyenv/shims/vncdo; then
  # enable UAMDM profiles
  echo "enable UAMDM profiles...15 seconds..."
  /Users/vao/.pyenv/shims/vncdo -s "${VNCSTR}" -p admin move 220 180 click 1 pause 2 \
    move 0 0 click 1 pause 2 \
    type "s" key enter pause 2 \
    type "profiles" pause 2 \
    key return pause 2 \
    move 570 240 click 1 pause 2 \
    move 630 240 click 1
  # enable filevault
  echo "enabling filevault...60 seconds...."
  /Users/vao/.pyenv/shims/vncdo -s "${VNCSTR}" -p admin move 0 0 click 1 pause 2 \
    type "l" \
    key down \
    key return pause 2 \
    key return pause 5 \
    type "admin" \
    key return pause 5 \
    key return pause 30 \
    key return pause 5 \
    type "a" \
    key return pause 2 \
    type "admin" pause 2 \
    key return
else
  echo "vncdo not installed"
  exit 1
fi

anka suspend "$vm_name" && echo "$vm suspended."
exit 0

#!/bin/bash

identifier='gse'
vm_name=$(anka list | grep -i "$identifier" | awk -F\| '{print $2}' | tr -d ' ')

if ! [[ $(anka show "$vm_name" status) == running ]]; then
  if anka show "$vm_name" status | grep -E suspended; then
    anka start "$vm_name" && echo "vm started from suspension"
    sleep 2
  elif anka show "$vm_name" status | grep -E stopped; then
    anka start "$vm_name" && echo "vm started from stop"
    sleep 5
  fi
fi

VNCSTR=$(anka show "$vm_name" vnc_connection_string | awk -F\/\/ '{print $NF}')
echo "VNCSTR: $VNCSTR"

if which /Users/vao/.pyenv/shims/vncdo; then
  # enable UAMDM profiles
  echo "enable UAMDM profiles...15 seconds..."
  /Users/vao/.pyenv/shims/vncdo -s "${VNCSTR}" -p admin move 250 225 click 1 pause 2 \
    move 0 0 click 1 pause 2 \
    type "s" key enter pause 2 \
    type "profiles" pause 2 \
    key return pause 2 \
    move 600 235 click 1 pause 2 \
    move 660 240 click 1 pause 2 \
    key super-q
  # enable filevault
  echo "enabling filevault...60 seconds...."
  /Users/vao/.pyenv/shims/vncdo -s "${VNCSTR}" -p admin key super-shift-q \
    key return pause 5 \
    type "admin" \
    key return pause 5 \
    key return pause 20 \
    key return pause 5 \
    type "a" \
    key return pause 5 \
    type "admin" pause 2 \
    key return pause 5
#   echo "provisioning machine..."
#   /Users/vao/.pyenv/shims/vncdo -s "${VNCSTR}" -p admin key super-space pause 1\
#     type "terminal" pause 1 \
#     key return pause 2 \
#     type "sudo jamf recon" pause 1 \
#     key return pause 30 \
#     type "sudo jamf policy -event DEPInitialConfig" \
#     key return pause 1
else
  echo "vncdo not installed"
  exit 1
fi

echo "machine has been enrolled, waiting 30 for polices to install..."
sleep 30
# anka suspend "$vm_name" && echo "$vm suspended."
exit 0

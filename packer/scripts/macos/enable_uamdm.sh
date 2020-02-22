#!/bin/bash

identifier='gse'
vm_name=$(anka list | grep -i "$identifier" | awk -F\| '{print $2}' | tr -d ' ')

anka start "$vm_name"
sleep 5

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
    move 630 240 click 1 pause 2 \
    key super-q
  # enable filevault
  echo "enabling filevault...60 seconds...."
  /Users/vao/.pyenv/shims/vncdo -s "${VNCSTR}" -p admin key super-shift-q \
    key return pause 10 \
    type "admin" key return pause 2 \
    key return pause 20 \
    key return pause 5 \
    type "a" key return pause 2 \
    type "admin" key return pause 10
  echo "provisioning machine..."
  /Users/vao/.pyenv/shims/vncdo -s "${VNCSTR}" -p admin key super-space pause 1\
    type "terminal" pause 1 \
    key return pause 2 \
    type "sudo jamf recon" pause 1 \
    key return pause 30 \
    type "sudo jamf policy -event DEPInitialConfig" \
    key return pause 30
  echo "kickstart..."
  /Users/vao/.pyenv/shims/vncdo -s "${VNCSTR}" -p admin key super-space pause 1\
    type "kickstart" \
    key return pause 230 \
    move 860 655 click 1 pause 2 \
    key return
else
  echo "vncdo not installed"
  exit 1
fi

# echo "machine has been enrolled, waiting 30 for polices to install..."
# sleep 30
# anka suspend "$vm_name" && echo "$vm suspended."
exit 0

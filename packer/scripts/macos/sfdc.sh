#!/bin/bash

working_dir="/tmp/profiles"

OLDIFS=$IFS

IFS=$'\n'

declare -a config_profiles=($(ls $working_dir))

for i in "${config_profiles[@]}"; do
  if /usr/bin/profiles install -path "$working_dir/$i"; then
    echo "$i installed"
  else
    echo "$i failed to install"
    exit 1
  fi
done

IFS=$OLDIFS

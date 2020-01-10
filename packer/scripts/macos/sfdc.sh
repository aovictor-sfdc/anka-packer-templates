#!/bin/bash

/usr/bin/profiles install -path "/Users/anka/Desktop/profiles/CA Certificate.mobileconfig"
/usr/bin/profiles install -path "/Users/anka/Desktop/profiles/enrollmentProfile.mobileconfig"

osascript "/Users/anka/Desktop/profiles/user_accept.scpt"

# /usr/bin/profiles install -path "/Users/anka/Desktop/profiles/CA Certificate.mobileconfig"
# /usr/bin/profiles install -path "/Users/anka/Desktop/profiles/enrollmentProfile.mobileconfig"
#
# working_dir="/var/tmp/profiles"
#
# OLDIFS=$IFS
#
# IFS=$'\n'
#
# declare -a config_profiles=($(ls $working_dir))
#
# for i in "${config_profiles[@]}"; do
#   if /usr/bin/profiles install -path "$working_dir/$i"; then
#     echo "$i installed"
#   else
#     echo "$i failed to install"
#     exit 1
#   fi
# done
#
# IFS=$OLDIFS

#!/bin/bash

# set comp name
ADCompName="gse-qa-vm"

/usr/sbin/scutil --set ComputerName "$ADCompName" && echo "ComputerName set"
/usr/sbin/scutil --set LocalHostName "$ADCompName" && echo "LocalHostName set"
/usr/sbin/scutil --set HostName "$ADCompName.internal.salesforce.com" && echo "Hostname set"

# Enroll into jamf
/usr/sbin/installer -pkg "/Users/anka/Desktop/profiles/Production_QuickAdd_5.19.pkg" -target / &
echo "jamf enrolled."

# kill any jamf prompt
echo "sleep 90 while enrolling"
sleep 90
/usr/bin/killall KeyboardSetupAssistant && echo "keyboard setup ast killed"
/usr/bin/killall jamfHelper && echo "jamfHelper killed"
echo "sleep 30 for policies"
sleep 30

exit 0

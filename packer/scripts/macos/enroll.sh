#!/bin/bash

# set comp name
CompName="gse-qa-vm$RANDOM"

/usr/sbin/scutil --set ComputerName "$CompName"
/usr/sbin/scutil --set LocalHostName "$CompName"
/usr/sbin/scutil --set HostName "$ADCompName.internal.salesforce.com"
echo "VM name set to $CompName"

# Enroll into jamf
/usr/sbin/installer -pkg "/Users/anka/Desktop/profiles/Production_QuickAdd_5.19.pkg" -target / &
# /usr/bin/profiles -I -F "/Users/anka/Desktop/profiles/jamf/CA Certificate.mobileconfig"
# /usr/bin/profiles -I -F "/Users/anka/Desktop/profiles/jamf/enrollmentProfile.mobileconfig"
echo "jamf enrolling..."

/usr/bin/killall KeyboardSetupAssistant && echo "KeyboardSetupAssistant killed"

# delay Filevault
while ! pgrep -i jamfhelper; do sleep 1; done
/usr/bin/killall jamfHelper && echo "jamfHelper killed...delaying filevault setup..."

exit 0

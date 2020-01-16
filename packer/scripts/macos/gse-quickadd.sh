#!/bin/bash

# /usr/sbin/installer -pkg "/Users/anka/Desktop/profiles/QuickAddDev-10.21.2018.pkg" -target /
/usr/sbin/installer -pkg "/Users/anka/Desktop/profiles/Production_QuickAdd_5.19.pkg" -target /


ADCompName="gse-qa-vm"

/usr/sbin/scutil --set ComputerName "$ADCompName"
/usr/sbin/scutil --set LocalHostName "$ADCompName"
/usr/sbin/scutil --set HostName "$ADCompName.internal.salesforce.com"
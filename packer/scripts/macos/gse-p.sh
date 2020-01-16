#!/bin/bash

/usr/bin/profiles install -path "/Users/anka/Desktop/profiles/CA Certificate.mobileconfig"
/usr/bin/profiles install -path "/Users/anka/Desktop/profiles/enrollmentProfile.mobileconfig"

ADCompName="gse-p-vm"

/usr/sbin/scutil --set ComputerName "$ADCompName"
/usr/sbin/scutil --set LocalHostName "$ADCompName"
/usr/sbin/scutil --set HostName "$ADCompName.internal.salesforce.com"

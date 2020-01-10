tell application "System Preferences" to activate

tell application "System Events"
	tell application process "System Preferences"
		set currentWindow to name of window 1
		if currentWindow does not contain "Profiles" then
			click button "Show All" of group 1 of group 2 of toolbar 1 of window 1
			delay 2
			click button "Profiles" of scroll area 1 of window "System Preferences"
			delay 2
		end if

		tell window "Profiles"
			tell scroll area 2
				repeat with aRow in row of table 1
					if value of static text of UI element 1 of aRow starts with "MDM Profile" then
						select aRow
						delay 1
					end if
				end repeat
			end tell
			click button "Approve…" of scroll area 1
			click button "Approve" of sheet 1
		end tell
	end tell
end tell

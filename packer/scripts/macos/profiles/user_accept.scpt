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
		set currentWindow to name of window 1
		if currentWindow does not contain "Privacy" then
			click button "Show All" of group 1 of group 2 of toolbar 1 of window 1
			delay 2
			#get name of every UI element of scroll area 1 of window 1
			click button "Security
& Privacy" of scroll area 1 of window "System Preferences"
			delay 2
		end if
		tell window "Security & Privacy"
			click radio button "Privacy" of tab group 1
			delay 1
			tell tab group 1
				tell scroll area 1
					repeat with aRow in row of table 1
						if value of static text of UI element 1 of aRow starts with "Accessibility" then
							select aRow
							delay 1
						end if
					end repeat
				end tell
			end tell
			try
				click button "Click the lock to make changes."
				repeat 1000 times
					if (accessibility description of button 1) contains "Click the lock to prevent further changes." then exit repeat
				end repeat
				tell tab group 1
					tell group 1
						tell scroll area 1
							repeat with aRow in row of table 1
								if value of static text of UI element 1 of aRow starts with "Script Editor" then
									select aRow
									delay 1
								end if
							end repeat
						end tell
					end tell
				end tell
				click button 2 of group 1 of group 1 of tab group 1
			on error
				tell tab group 1
					tell group 1
						tell scroll area 1
							repeat with aRow in row of table 1
								if value of static text of UI element 1 of aRow starts with "Script Editor" then
									select aRow
									delay 1
								end if
							end repeat
						end tell
					end tell
				end tell
				click button 2 of group 1 of group 1 of tab group 1
			end try
		end tell
	end tell
end tell

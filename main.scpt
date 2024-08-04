on run
	do shell script "open -n /Applications/mpv.app"
	tell application "mpv" to activate
end run

on open theFiles
	repeat with theFile in theFiles
		do shell script "open -na /Applications/mpv.app " & quote & (POSIX path of theFile) & quote
	end repeat
	tell application "mpv" to activate
end open

on open location this_URL
	set AppleScript's text item delimiters to the "mmpv://"
	set the item_list to every text item of this_URL
	set the v_url to item 2 of item_list
	
	--display dialog "url:" & v_url
	-- Check if there are parameters after @
	if v_url contains "@" then
		set AppleScript's text item delimiters to "@"
		set parts to every text item of v_url
		set the v_url to item 1 of parts
		set param_string to item 2 of parts
		
		-- Replace & with space and = with space and --
		set AppleScript's text item delimiters to "_"
		set param_list to every text item of param_string
		set formatted_params to ""
		repeat with param in param_list
			set AppleScript's text item delimiters to "="
			set key_value to every text item of param
			if (count of key_value) = 2 then
				set formatted_params to formatted_params & " --" & item 1 of key_value & "=" & item 2 of key_value
			else
				set formatted_params to formatted_params & " --" & item 1 of key_value
			end if
		end repeat
	else
		set formatted_params to ""
	end if
	
	-- Correct the URL prefix if necessary
	if v_url starts with "http//" then
		set v_url to "http://" & text 7 thru -1 of v_url
	else if v_url starts with "https//" then
		set v_url to "https://" & text 8 thru -1 of v_url
	end if
	
	-- Construct the full command¬
	
	set full_command to "open -na /Applications/mpv.app " & quoted form of v_url & " --args" & formatted_params
	
	--display dialog full_command
	-- Execute the command
	do shell script full_command
	
	tell application "mpv" to activate
end open location

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
	
	if v_url starts with "http//" then
		set v_url to "http://" & text 7 thru -1 of v_url
	else if v_url starts with "https//" then
		set v_url to "https://" & text 8 thru -1 of v_url
	end if
	
	-- display dialog "url: " & v_url
	do shell script "open -na /Applications/mpv.app " & quote & v_url & quote
	tell application "mpv" to activate
end open location

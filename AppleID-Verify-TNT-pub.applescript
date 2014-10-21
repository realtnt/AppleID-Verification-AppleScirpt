set ourDomain to "domain.com"
set secretWord to "yourPassword"

tell application "Mail"
	
	set selectionMessage to selection -- just select the first message in the folder
	set thisMessage to item 1 of selectionMessage
	set theseMessages to (every message in (mailbox of thisMessage)) -- if there are no messages selected, warn the user and then quit
	
	if theseMessages is {} then
		display dialog "Please select a message first and then run this script." with icon 1
		return
	end if
	
	repeat with theMessage in theseMessages
		
		-- My emails were formed as follows: ipad-01@domain.com
		-- The following code parses the above into two words:
		-- Word 'a' is ipad and word 'b' is 01
		-- Also, I had set different passwords for each account with the following format: ipad-secretword-01
		-- if you have the same password for all of your accounts, set it as the secretWord
		-- at the top of this file and leave the script as it is.
		
		set theContent to source of theMessage
		set parsedname to do shell script "echo " & (quoted form of theContent) & " | grep 'Dear '"
		set a to word 2 of parsedname
		set b to word 3 of parsedname
		set aidEmail to a & "-" & b & "@" & ourDomain
		set aidPassword to secertWord
		-- set aidPassword to a & "-" & secretWord & "-" & b
		
		set thelist to {} --this will store the URL's
		
		set startofurl to the offset of "https://id" in theContent
		set theContent to rich text startofurl through -1 of theContent
		set endofurl to offset of "en_GB" in theContent
		
		-- the following 3 lines of code just clean up the link as it was getting
		-- some funny characters because it was encoded as QUOTED PRINTABLE
		set theLink to rich text 1 through (endofurl + 5) of theContent
		set theLink to replace_chars(theLink, "=3D", "=") of me
		set theLink to replace_chars(theLink, "=
", "") of me
				
		tell application "Safari"
			open location theLink
			
			delay 5
			
			do JavaScript "document.forms['command']['appleId'].value = '" & aidEmail & "'" in document 1
			do JavaScript "document.forms['command']['accountPassword'].value = '" & aidPassword & "'" in document 1
			do JavaScript "document.forms['command'].submit()" in document 1
			
			tell window 1 of application "Safari" to close (tabs where index < (get index of current tab))
			
		end tell
	end repeat
end tell

on replace_chars(this_text, search_string, replacement_string)
	set AppleScript's text item delimiters to the search_string
	set the item_list to every text item of this_text
	set AppleScript's text item delimiters to the replacement_string
	set this_text to the item_list as string
	set AppleScript's text item delimiters to ""
	return this_text
end replace_chars
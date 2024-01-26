Apple ID Verification
---------------------

### Purpose & Features

After creating Apple IDs for deploying a large quantity of iOS devices 
we need to go through the time-consuming process of verifying them. This
consists of opening an email, clicking a link and entering the Apple ID
credentials in a form.

### Requirements

- I created this script to use Mail and Safari which exist on every Mac.

- All the verification emails must be on the same mailbox. You can do this
by creating all the Apple IDs using email aliases to one master email.

### Instructions

- Edit the script variables at the very top of the script to reflect your 
password and domain.

NOTE: If you're using the same password for all Apple IDs then just make the
changes and leave the script unchanged. I used a different password for 
each ID (I was told by an Apple rep that I had to) with the following
format: `iPad-secretword-01`
You can easily replicate that type of format by modifying the commented out
line in the script:
set `aidPassword to a & "-" & secretWord & "-" & b`

- Open Safari and Mail.

- Run script.


### Known Bugs

No checking on whether Mail is open or not. If it is not the script will fail.


### Download

The files are downloadable from GitHub:
https://github.com/realtnt/Apple-ID-AppleScript Feel free to fork
and improve.

Brought to you by [realtnt][]

  [ntoqiakt]: https://github.com/ntoqiakt

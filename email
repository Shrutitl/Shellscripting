#!/bin/bash

RECIPIENT="recipient@example.com"
SUBJECT="Home Directory Cleanup"
MESSAGE="Hello,\n\nThis email provides a list of the top 10 users whose home directories have the highest disk usage:\n\n"

# Run 'du' command to get disk usage for each home directory
du_output=$(du -sh /home/* 2>/dev/null | sort -rh | head -n 10)

# Add du output to the email message
MESSAGE="$MESSAGE$du_output\n\nPlease consider cleaning up unnecessary files to free up disk space.\n\nThank you!"

echo -e "$MESSAGE" | mailx -s "$SUBJECT" "$RECIPIENT"

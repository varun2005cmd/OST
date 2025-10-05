#!/bin/bash

REMINDER_FILE="reminders.txt"

if [ -f "$REMINDER_FILE" ]; then
    while IFS= read -r line
    do
        notify-send "📅 Daily Reminder: $line"
    done < "$REMINDER_FILE"
else
    echo "No reminders found."
fi

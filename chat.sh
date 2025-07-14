#!/bin/bash

# Path to the shared chat file
CHAT_FILE="/tmp/chat_channel.log"

# Get the current username
USER_NAME=$(whoami)

# Define ANSI color codes
COLOR_RESET="\e[0m"
COLOR_SELF="\e[32m"    # Green for own messages
COLOR_OTHER="\e[34m"   # Blue for others' messages

# Function to play a terminal beep sound
play_beep() {
    echo -ne '\a'
}

# Start a background process to display live chat messages
tail -n 10 -f "$CHAT_FILE" | while read -r line; do
    # Extract the username from each line
    sender=$(echo "$line" | cut -d':' -f2 | cut -d' ' -f2)

    # If the message is from the current user, use green color
    if [[ "$sender" == "$USER_NAME" ]]; then
        echo -e "${COLOR_SELF}$line${COLOR_RESET}"
    else
        # Otherwise, display in blue and beep
        echo -e "${COLOR_OTHER}$line${COLOR_RESET}"
        play_beep
    fi
done &

# Save the PID of the background tail process
TAIL_PID=$!

# Main loop to read user input and write to the chat log
while true; do
    read -p "$USER_NAME> " msg
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] $USER_NAME: $msg" >> "$CHAT_FILE"
done

# If script exits, kill the tail process
kill $TAIL_PID

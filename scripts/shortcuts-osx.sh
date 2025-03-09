#!/bin/bash

# Make sure Chrome is closed before running this
osascript -e 'tell application "Google Chrome" to quit'

# Wait a moment for Chrome to fully close
sleep 2

# Set custom keyboard shortcuts for Chrome
defaults write com.google.Chrome NSUserKeyEquivalents '{
    "Back"="^[";
    "Forward"="^]";
    "New Tab"="^t";
    "Close Tab"="^w";
    "Next Tab"="^\\U0009";
    "Previous Tab"="^$\\U0009";
    "Reopen Closed Tab"="^$t";
    "Copy"="^c";
    "Paste"="^v";
    "Cut"="^x";
    "Select All"="^a";
}' 

echo "Chrome shortcuts have been set! Restart Chrome to apply changes."
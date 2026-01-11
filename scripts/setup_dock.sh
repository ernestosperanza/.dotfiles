#!/bin/bash

# This script configures the macOS Dock with your preferred applications.

# First, it removes all existing application icons from the Dock.
echo "Cleaning the Dock (applications only)..."
# We use --no-restart to batch the changes before restarting the Dock.
dockutil --remove all --no-restart

# Next, it adds the desired applications in the specified order.
# Make sure the application paths are correct for your system.
echo "Adding your applications to the Dock..."

# System Applications
dockutil --add '/System/Applications/System Settings.app' --no-restart

# Other Applications
dockutil --add '/Applications/iTerm.app' --no-restart 
dockutil --add '/Applications/Things3.app' --no-restart
dockutil --add '/Applications/Google Chrome.app' --no-restart
dockutil --add '/Applications/Obsidian.app' --no-restart
dockutil --add '/Applications/WhatsApp.app' --no-restart
dockutil --add '/Applications/Spotify.app' --no-restart

# Finally, it restarts the Dock for all changes to take effect.
echo "Restarting the Dock to apply changes..."
killall Dock

echo "The Dock has been configured with your applications!"

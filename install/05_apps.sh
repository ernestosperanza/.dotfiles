#!/bin/bash
# install/05_apps.sh
# Phase 05: Application Setup - Configures specific applications.

set -euo pipefail

# --- Configuration ---
TARGET_DOTFILES_DIR="${HOME}/.dotfiles"


# --- Main Execution ---
log_info "Starting Phase 05: Application Specific Setup."

# 1. iTerm2 Profile Import
log_info "Configuring iTerm2 profile..."
ITerm2_PROFILE_SOURCE="${TARGET_DOTFILES_DIR}/.config/iterm2/profile.json" # Assuming this path for the profile
if [[ -f "$ITerm2_PROFILE_SOURCE" ]]; then
    log_info "iTerm2 profile found at ${ITerm2_PROFILE_SOURCE}. It can be manually imported via iTerm2 Preferences -> Profiles -> Other Actions -> Import JSON Profiles."
    log_info "For full automation, you might need to use AppleScript or `defaults write` to configure iTerm2."
    # Example for defaults write (can be complex and version-dependent):
    # defaults write com.googlecode.iterm2 PrefsCustomFolder -string "${TARGET_DOTFILES_DIR}/.config/iterm2"
    # defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
else
    log_warn "iTerm2 profile not found at ${ITerm2_PROFILE_SOURCE}. Skipping iTerm2 configuration."
fi


# 2. Activate Karabiner-Elements Rules
log_info "Activating Karabiner-Elements rules..."
KARABINER_CONFIG_DIR="${HOME}/.config/karabiner"
KARABINER_CONFIG_FILE="${KARABINER_CONFIG_DIR}/karabiner.json"

if command -v karabiner_cli &> /dev/null; then
    if [[ -L "$KARABINER_CONFIG_FILE" && -f "$KARABINER_CONFIG_FILE" ]]; then
        log_info "Karabiner-Elements config symlink detected. Attempting to restart Karabiner-Elements to apply rules."
        # This might not always work perfectly in a script, sometimes a manual restart or login is needed.
        # karabiner_cli --reload-config
        # sleep 1 # Give it a moment
        # karabiner_cli --launch
        log_info "Karabiner-Elements configuration should be active via stow. A manual restart of Karabiner-Elements might be required if rules aren't applied."
    else
        log_warn "Karabiner-Elements config not found or not symlinked. Ensure ~/.config/karabiner/karabiner.json points to your dotfiles."
    fi
else
    log_warn "Karabiner-Elements CLI (karabiner_cli) not found. Please ensure Karabiner-Elements is installed."
fi


# 3. Load AeroSpace Config
log_info "Loading AeroSpace configuration..."
AEROSPACE_CONFIG_DIR="${HOME}/.config/aerospace"
AEROSPACE_CONFIG_FILE="${AEROSPACE_CONFIG_DIR}/aerospace.toml"

if command -v aerospace &> /dev/null; then
    if command -v brew &> /dev/null && brew services list | grep -q "aerospace"; then
        log_info "AeroSpace config symlink detected. Restarting AeroSpace via brew services."
        brew services restart aerospace || log_warn "Failed to restart AeroSpace via brew services. Manual restart might be needed."
    elif [[ -L "$AEROSPACE_CONFIG_FILE" && -f "$AEROSPACE_CONFIG_FILE" ]]; then
        log_warn "AeroSpace found, config symlinked, but not managed by brew services. AeroSpace might need to be manually launched/restarted (e.g., 'aerospace start')."
    else
        log_warn "AeroSpace config not found or not symlinked. Ensure ~/.config/aerospace/aerospace.toml points to your dotfiles."
    fi
else
    log_warn "AeroSpace CLI not found. Please ensure AeroSpace is installed."
fi


# 4. Raycast Extensions Setup
log_info "Setting up Raycast extensions..."
log_info "Raycast extension setup is highly user-specific and often involves interactive steps."
log_info "Refer to your Raycast preferences for importing / exporting extensions and settings."
log_info "Consider using Raycast's built-in 'Sync' feature or a custom Raycast import script if available."




log_info "Phase 05 completed: Application specific configurations applied (or noted for manual action)."

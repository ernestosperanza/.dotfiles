#!/bin/bash
# install/03_macos.sh
# Phase 03: macOS Defaults - Executes the .macos script to set system preferences.

set -euo pipefail

# --- Configuration ---
MACOS_DEFAULTS_SCRIPT="${HOME}/.dotfiles/.macos"


# --- Main Execution ---
log_info "Starting Phase 03: macOS Defaults Configuration."

# 1. Check for the .macos script
if [[ ! -f "$MACOS_DEFAULTS_SCRIPT" ]]; then
    log_error "macOS defaults script not found at ${MACOS_DEFAULTS_SCRIPT}. Please ensure this file exists and contains your desired macOS defaults."
fi

if [[ ! -x "$MACOS_DEFAULTS_SCRIPT" ]]; then
    log_warn "macOS defaults script at ${MACOS_DEFAULTS_SCRIPT} is not executable. Attempting to make it executable."
    chmod +x "$MACOS_DEFAULTS_SCRIPT" || log_error "Failed to make ${MACOS_DEFAULTS_SCRIPT} executable."
fi

# 2. Execute the .macos script
log_info "Executing custom macOS defaults script..."
"${MACOS_DEFAULTS_SCRIPT}"

# 3. Inform user about potential restarts
log_info "macOS defaults applied. Some changes may require restarting applications like Finder or Dock, or logging out."
log_info "You might want to manually restart affected services, e.g., 'killall Dock Finder SystemUIServer'."

log_info "Phase 03 completed: macOS defaults configured."

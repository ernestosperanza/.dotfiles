#!/bin/bash
# install/01_packages.sh
# Phase 01: Package Installation - Installs all packages, casks, and MAS apps via Brewfile.

set -euo pipefail

# --- Configuration ---
TARGET_DIR="${HOME}/.dotfiles"
BREWFILE_PATH="${TARGET_DIR}/Brewfile"


# --- Main Execution ---
log_info "Starting Phase 01: Package Installation."

# Ensure Homebrew is available
if ! command -v brew &> /dev/null; then
    log_error "Homebrew is not installed. Please run 00_preflight.sh first."
fi

# Ensure Brewfile exists
if [[ ! -f "$BREWFILE_PATH" ]]; then
    log_error "Brewfile not found at ${BREWFILE_PATH}. Aborting package installation."
fi

log_info "Running 'brew bundle' to install packages, casks, and MAS apps from Brewfile..."
# The --no-upgrade flag prevents re-downloading/re-installing if already present,
# which helps with idempotency and speed on subsequent runs.
# The --no-lock flag prevents writing a Brewfile.lock, which is generally good for dotfiles.
brew bundle --file="$BREWFILE_PATH" --no-upgrade --no-lock

log_info "Running 'brew cleanup' to remove old versions and downloads..."
brew cleanup

log_info "Phase 01 completed: All packages from Brewfile installed and cleaned up."

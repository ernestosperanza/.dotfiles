#!/bin/bash
# install/00_preflight.sh
# Phase 00: Preflight Checks - Verifies macOS version, internet, and installs essential tools.

set -euo pipefail

# --- Configuration ---
MIN_MACOS_VERSION="13.0" # Ventura+ as per plan
TARGET_DIR="${HOME}/.dotfiles"


check_macos_version() {
    log_info "Verifying macOS version (Ventura or newer)..."
    CURRENT_VERSION=$(sw_vers -productVersion)
    if printf '%s\n' "$MIN_MACOS_VERSION" "$CURRENT_VERSION" | sort -V -C; then
        log_info "macOS version check passed: Current version is ${CURRENT_VERSION} (minimum required: ${MIN_MACOS_VERSION})."
    else
        log_error "macOS version check failed: Current version ${CURRENT_VERSION} is older than required ${MIN_MACOS_VERSION}. Please upgrade macOS."
    fi
}

check_xcode_clt() {
    log_info "Checking for Xcode Command Line Tools..."
    if ! xcode-select -p &> /dev/null; then
        log_error "Xcode Command Line Tools not found. Please install them first by running 'xcode-select --install' as per the README, then rerun this script."
    else
        log_info "Xcode Command Line Tools are already installed."
    fi
}

install_homebrew() {
    log_info "Checking for Homebrew..."
    if ! command -v brew &> /dev/null; then
        log_info "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        log_info "Homebrew installed."

        # After installation, brew is not in the PATH. We need to eval it manually once.
        # We check both possible installation paths for Apple Silicon and Intel.
        if [[ -x "/opt/homebrew/bin/brew" ]]; then
             log_info "Temporarily setting up environment from /opt/homebrew..."
             eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -x "/usr/local/bin/brew" ]]; then
             log_info "Temporarily setting up environment from /usr/local..."
             eval "$(/usr/local/bin/brew shellenv)"
        else
             log_error "Could not find brew executable after installation."
        fi
    else
        log_info "Homebrew is already installed."
    fi

    # By this point, 'brew' should be in the PATH for the current session.
    log_info "Configuring shell environment for Homebrew..."
    local brew_prefix
    brew_prefix=$(brew --prefix)

    if [ -z "$brew_prefix" ]; then
        log_error "Could not determine Homebrew prefix. Aborting."
    fi
    
    # Add Homebrew to .zprofile to make it available in future Zsh sessions
    local zprofile_path="${HOME}/.zprofile"
    # Explicitly generate the command for zsh, as this is the user's login shell.
    local zsh_shellenv_command='eval "$($(brew --prefix)/bin/brew shellenv zsh)"'
    
    # Use a more general grep to avoid adding duplicates if a similar line already exists.
    if ! grep -q "brew shellenv" "$zprofile_path" 2>/dev/null; then
        log_info "Adding Homebrew to ${zprofile_path} for future Zsh sessions..."
        echo -e "\n# Homebrew" >> "$zprofile_path"
        echo "$zsh_shellenv_command" >> "$zprofile_path"
    else
        log_info "Homebrew seems to be already configured in ${zprofile_path}."
    fi

    log_info "Updating Homebrew and running doctor..."
    brew update
    brew doctor
    log_info "Homebrew updated and checked."
}

# --- Main Execution ---
log_info "Starting Phase 00: Preflight Checks and Essential Tools Installation."

check_macos_version
check_xcode_clt
install_homebrew

log_info "Phase 00 completed: Essential tools are ready."

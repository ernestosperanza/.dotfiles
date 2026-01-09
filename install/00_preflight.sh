#!/bin/bash
# install/00_preflight.sh
# Phase 00: Preflight Checks - Verifies macOS version, internet, and installs essential tools.

set -euo pipefail

# --- Configuration ---
MIN_MACOS_VERSION="13.0" # Ventura+ as per plan
TARGET_DIR="${HOME}/.dotfiles"

# --- Helper Functions ---

log_info() {
    echo "INFO: $1"
}

log_warn() {
    echo "WARN: $1" >&2
}

log_error() {
    echo "ERROR: $1" >&2
    exit 1
}

check_macos_version() {
    log_info "Verifying macOS version (Ventura or newer)..."
    CURRENT_VERSION=$(sw_vers -productVersion)
    if printf '%s\n' "$MIN_MACOS_VERSION" "$CURRENT_VERSION" | sort -V -C; then
        log_info "macOS version check passed: Current version is ${CURRENT_VERSION} (minimum required: ${MIN_MACOS_VERSION})."
    else
        log_error "macOS version check failed: Current version ${CURRENT_VERSION} is older than required ${MIN_MACOS_VERSION}. Please upgrade macOS."
    fi
}

check_internet_connectivity() {
    log_info "Checking internet connectivity..."
    if curl -s --head --request GET "https://google.com" | grep "200 OK" > /dev/null; then
        log_info "Internet connectivity check passed."
    else
        log_error "Internet connectivity check failed. Please ensure you have an active internet connection."
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
        # Ensure Homebrew is in PATH for subsequent commands in this script
        eval "$(/opt/homebrew/bin/brew shellenv)"
        log_info "Homebrew installed successfully."
    else
        log_info "Homebrew is already installed."
    fi

    log_info "Updating Homebrew and running doctor..."
    brew update
    brew doctor
    log_info "Homebrew updated and checked."
}

# --- Main Execution ---
log_info "Starting Phase 00: Preflight Checks and Essential Tools Installation."

check_macos_version
check_internet_connectivity
check_xcode_clt
install_homebrew

log_info "Phase 00 completed: Essential tools are ready."

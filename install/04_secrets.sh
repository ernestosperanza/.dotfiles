#!/bin/bash
# install/04_secrets.sh
# Phase 04: Secrets Management - Authenticates 1Password CLI and generates local secrets cache.

set -euo pipefail

# --- Configuration ---
GENERATE_SECRETS_SCRIPT="${HOME}/.dotfiles/scripts/generate-secrets.sh"


# --- Main Execution ---
log_info "Starting Phase 04: 1Password Secrets Management."

# 1. Prepare 1Password config directory
OP_CONFIG_DIR="${HOME}/.config/op"
log_info "Ensuring 1Password config directory exists and has correct permissions..."
mkdir -p "$OP_CONFIG_DIR"
chmod 700 "$OP_CONFIG_DIR"
log_info "Permissions for ${OP_CONFIG_DIR} set to 700."

# 2. Check if 1Password CLI (op) is installed
if ! command -v op &> /dev/null; then
    log_error "1Password CLI ('op') is not installed. Please ensure it's in your Brewfile and 01_packages.sh was run."
fi

# 3. Authenticate 1Password CLI (if not already)
log_info "Checking 1Password CLI authentication status..."
if ! op whoami &> /dev/null; then
    log_info "1Password CLI not authenticated. Please sign in now."
    log_info "This is an interactive step. You will need to provide your 1Password account details and master password."
    log_info "Running 'op signin'..."
    op signin || log_error "Failed to sign in to 1Password CLI."
    log_info "1Password CLI authenticated successfully."
else
    log_info "1Password CLI is already authenticated."
fi

# 3. Generate the local secrets cache
log_info "Generating local secrets cache from 1Password..."
if [[ ! -f "$GENERATE_SECRETS_SCRIPT" ]]; then
    log_error "Secrets generation script not found at ${GENERATE_SECRETS_SCRIPT}. Please ensure it was created."
fi
if [[ ! -x "$GENERATE_SECRETS_SCRIPT" ]]; then
    log_warn "Secrets generation script at ${GENERATE_SECRETS_SCRIPT} is not executable. Attempting to make it executable."
    chmod +x "$GENERATE_SECRETS_SCRIPT" || log_error "Failed to make ${GENERATE_SECRETS_SCRIPT} executable."
fi

"${GENERATE_SECRETS_SCRIPT}" || log_error "Failed to generate local secrets cache."

log_info "Phase 04 completed: 1Password CLI authenticated and local secrets cache generated."
log_info "Your secrets are now cached in ~/.local/state/secrets_cache.sh and will be sourced by your shell."

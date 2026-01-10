#!/bin/bash
# install/02_stow.sh
# Phase 02: Dotfiles Stow - Creates symlinks from the dotfiles directory.
# This simplified script assumes it's being run on a new machine with no conflicting dotfiles.

set -euo pipefail

# --- Configuration ---
TARGET_DOTFILES_DIR="${HOME}/.dotfiles"

# --- Main Execution ---
log_info "Starting Phase 02: Dotfiles Stow."

# 1. Check for stow installation
if ! command -v stow &> /dev/null; then
    log_error "Stow is not installed. Please ensure it's in your Brewfile and 01_packages.sh was run."
fi

# 2. Run stow
log_info "Running 'stow' to create symlinks..."
log_warn "This simplified script assumes no dotfile conflicts and will NOT back up any existing files."

# The '.' as the last argument tells stow to link everything at the top level
# of the TARGET_DOTFILES_DIR (excluding what's in .stow-local-ignore)
stow --target="${HOME}" --dir="${TARGET_DOTFILES_DIR}" . --verbose

log_info "Phase 02 completed: Dotfiles symlinked."
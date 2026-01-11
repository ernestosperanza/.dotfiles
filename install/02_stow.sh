#!/bin/bash
# install/02_stow.sh
# Phase 02: Dotfiles Stow - Creates symlinks from the dotfiles directory.
# This script assumes it can safely overwrite existing symlinks and specific conflicting files.

set -euo pipefail

# --- Configuration ---
TARGET_DOTFILES_DIR="${HOME}/.dotfiles"
CONFLICTING_FILES=( # List of files that might exist on a new system and can be safely deleted.
    "${HOME}/.zprofile"
)

# --- Main Execution ---
log_info "Starting Phase 02: Dotfiles Stow."

# 1. Check for stow installation
if ! command -v stow &> /dev/null; then
    log_error "Stow is not installed. Please ensure it's in your Brewfile and 01_packages.sh was run."
fi

# 2. Preemptively delete known conflicting files
log_info "Deleting known conflicting files before stowing..."
for file in "${CONFLICTING_FILES[@]}"; do
    if [[ -f "$file" && ! -L "$file" ]]; then
        log_warn "Deleting existing file: ${file}"
        rm "$file"
    fi
done

# 3. Run stow with --restow
log_info "Running 'stow --restow' to create/replace symlinks..."
# The -R (--restow) flag will unstow and then re-stow, overwriting any existing
# symlinks that were previously created by this script.
stow -R --target="${HOME}" --dir="${TARGET_DOTFILES_DIR}" . --verbose

log_info "Phase 02 completed: Dotfiles symlinked."

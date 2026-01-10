#!/bin/bash
# install/02_stow.sh
# Phase 02: Dotfiles Stow - Backs up existing dotfiles and creates symlinks.

set -euo pipefail

# --- Configuration ---
TARGET_DOTFILES_DIR="${HOME}/.dotfiles"
BACKUP_DIR="${TARGET_DOTFILES_DIR}/backup/stow_$(date +%Y%m%d-%H%M%S)"


# --- Main Execution ---
log_info "Starting Phase 02: Dotfiles Stow."

# 1. Check for stow installation
if ! command -v stow &> /dev/null; then
    log_error "Stow is not installed. Please ensure it's in your Brewfile and 01_packages.sh was run."
fi

# 2. Programmatically find and back up conflicting files
log_info "Simulating stow to find conflicting files..."
# We use stow's dry-run mode (-n) to see what it *would* do.
# The output will contain lines like "existing: ..." for files that conflict.
# We capture stderr because that's where stow reports these conflicts.
CONFLICTS=$(stow --no --target="${HOME}" --dir="${TARGET_DOTFILES_DIR}" . 2>&1 | grep 'existing:' || true)

if [[ -n "$CONFLICTS" ]]; then
    log_warn "Found conflicting files. Backing them up..."
    mkdir -p "${BACKUP_DIR}"

    # Use awk to parse the file paths from the stow output
    echo "$CONFLICTS" | awk -F': ' '{print $2}' | while read -r file; do
        TARGET_PATH="${HOME}/${file}"
        if [[ -f "${TARGET_PATH}" || -d "${TARGET_PATH}" ]] && [[ ! -L "${TARGET_PATH}" ]]; then
            log_info "Backing up '${file}' to ${BACKUP_DIR}/"
            # Use --parents to preserve directory structure if needed
            mv "${TARGET_PATH}" "${BACKUP_DIR}/"
        fi
    done
    log_info "Backup of conflicting files created in ${BACKUP_DIR}"
else
    log_info "No conflicting files found. No backup needed."
fi

# 3. Run stow for real
log_info "Running 'stow' to create symlinks..."
# Now that conflicting files are backed up, this should run without errors.
stow --target="${HOME}" --dir="${TARGET_DOTFILES_DIR}" . --verbose

log_info "Phase 02 completed: Dotfiles symlinked."

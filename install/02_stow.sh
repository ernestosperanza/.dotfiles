#!/bin/bash
# install/02_stow.sh
# Phase 02: Dotfiles Stow - Backs up existing dotfiles and creates symlinks.

set -euo pipefail

# --- Configuration ---
TARGET_DOTFILES_DIR="${HOME}/.dotfiles"
BACKUP_DIR="${TARGET_DOTFILES_DIR}/backup/$(date +%Y%m%d-%H%M%S)"
STOW_PACKAGES="." # Stow the entire .dotfiles directory from its own perspective
                  # (i.e., all top-level files/dirs except those in .stow-local-ignore)

# List of common dotfiles that might conflict and should be backed up
CRITICAL_DOTFILES=(
    ".zshrc"
    ".gitconfig"
    ".p10k.zsh"
    ".stow-local-ignore" # This is important to be backed up if it's not a symlink
    "Brewfile"           # The Brewfile itself
)

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

# --- Main Execution ---
log_info "Starting Phase 02: Dotfiles Stow."

# 1. Check for stow installation
if ! command -v stow &> /dev/null; then
    log_error "Stow is not installed. Please ensure it's in your Brewfile and 01_packages.sh was run."
fi

# 2. Backup existing conflicting dotfiles
log_info "Backing up existing dotfiles that might conflict..."
mkdir -p "${BACKUP_DIR}"

CONFLICT_FOUND=false
for dotfile in "${CRITICAL_DOTFILES[@]}"; do
    TARGET_PATH="${HOME}/${dotfile}"
    if [[ -f "${TARGET_PATH}" || -d "${TARGET_PATH}" ]] && [[ ! -L "${TARGET_PATH}" ]]; then
        log_warn "Conflicting file found: ${TARGET_PATH}. Moving to backup: ${BACKUP_DIR}/"
        mv "${TARGET_PATH}" "${BACKUP_DIR}/"
        CONFLICT_FOUND=true
    fi
done

if [[ "$CONFLICT_FOUND" == "true" ]]; then
    log_info "Backup created in ${BACKUP_DIR}"
else
    log_info "No conflicting dotfiles found for backup."
    rmdir "${BACKUP_DIR}" || true # Remove empty backup dir if nothing was moved
fi

# 3. Run stow
log_info "Running 'stow' to create symlinks from ${TARGET_DOTFILES_DIR} to ${HOME}..."
# The '.' as the last argument tells stow to link everything at the top level
# of the TARGET_DOTFILES_DIR (excluding what's in .stow-local-ignore)
stow --target="${HOME}" --dir="${TARGET_DOTFILES_DIR}" . --verbose

log_info "Symlinks created. Stow output above should indicate any conflicts or issues."

# 4. Verification (Stow reports conflicts, but we can add a basic check)
# Check for a few key symlinks to confirm stow worked
if [[ ! -L "${HOME}/.zshrc" ]]; then
    log_warn ".zshrc does not appear to be a symlink. Stow might have failed or encountered conflicts."
fi
if [[ ! -L "${HOME}/.gitconfig" ]]; then
    log_warn ".gitconfig does not appear to be a symlink. Stow might have failed or encountered conflicts."
fi

log_info "Phase 02 completed: Dotfiles symlinked."

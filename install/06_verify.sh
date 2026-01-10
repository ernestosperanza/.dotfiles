#!/bin/bash
# install/06_verify.sh
# Phase 06: Verification - Performs post-installation checks.

set -euo pipefail

# --- Configuration ---
TARGET_DOTFILES_DIR="${HOME}/.dotfiles"


# --- Main Execution ---
log_info "Starting Phase 06: Post-Installation Verification."

VERIFICATION_STATUS="SUCCESS"

# 1. Test Shell (zsh with p10k prompt)
log_info "Verifying default shell and Zsh setup..."
if [[ "$(basename "$SHELL")" == "zsh" ]]; then
    log_info "Default shell is Zsh."
else
    log_warn "Default shell is not Zsh. Current: $SHELL. Run 'chsh -s $(which zsh)' to set it."
    VERIFICATION_STATUS="WARNING"
fi
if command -v p10k &> /dev/null; then
    log_info "Powerlevel10k (p10k) is installed. Run 'p10k configure' to set up your prompt."
else
    log_warn "Powerlevel10k (p10k) not found. Ensure it's in your Brewfile and sourced in .zshrc."
    VERIFICATION_STATUS="WARNING"
fi

# 2. Test Git Config
log_info "Verifying Git configuration..."
GIT_USER_NAME=$(git config --global user.name)
GIT_USER_EMAIL=$(git config --global user.email)
GIT_EXCLUDES_FILE=$(git config --global core.excludesfile)

if [[ -n "$GIT_USER_NAME" ]]; then
    log_info "Git user.name set: ${GIT_USER_NAME}"
else
    log_warn "Git user.name not set. Run 'git config --global user.name \"Your Name\"'."
    VERIFICATION_STATUS="WARNING"
fi
if [[ -n "$GIT_USER_EMAIL" ]]; then
    log_info "Git user.email set: ${GIT_USER_EMAIL}"
else
    log_warn "Git user.email not set. Run 'git config --global user.email \"your_email@example.com\"'."
    VERIFICATION_STATUS="WARNING"
fi
if [[ "$GIT_EXCLUDES_FILE" == "${TARGET_DOTFILES_DIR}/.gitignore_global" ]]; then
    log_info "Git core.excludesfile correctly set to ~/.dotfiles/.gitignore_global."
else
    log_warn "Git core.excludesfile is not set correctly. Expected: ${TARGET_DOTFILES_DIR}/.gitignore_global. Current: ${GIT_EXCLUDES_FILE}."
    VERIFICATION_STATUS="WARNING"
fi

# 3. Test SSH Connectivity (via GitHub)
log_info "Testing SSH connectivity to GitHub..."
if command -v ssh &> /dev/null; then
    if ssh -T git@github.com &> /dev/null; then
        log_info "SSH connectivity to GitHub successful."
    else
        log_warn "SSH connectivity to GitHub failed. Ensure SSH keys (via YubiKey or otherwise) are set up correctly."
        VERIFICATION_STATUS="WARNING"
    fi
else
    log_warn "SSH client not found. Cannot test SSH connectivity."
    VERIFICATION_STATUS="WARNING"
fi

# 4. Run brew doctor
log_info "Running 'brew doctor' for Homebrew diagnostics..."
if command -v brew &> /dev/null; then
    brew doctor
else
    log_warn "Homebrew not found. Cannot run 'brew doctor'."
    VERIFICATION_STATUS="WARNING"
fi

# 5. Verify Key Symlinks
log_info "Verifying essential dotfile symlinks..."
ESSENTIAL_SYMLINKS=(
    "${HOME}/.zshrc"
    "${HOME}/.gitconfig"
    "${HOME}/.p10k.zsh"
    "${HOME}/Brewfile"
)
for link in "${ESSENTIAL_SYMLINKS[@]}"; do
    if [[ -L "$link" ]] && [[ "$(readlink "$link")" == *"${TARGET_DOTFILES_DIR}"* ]]; then
        log_info "Symlink verified: $link -> $(readlink "$link")"
    else
        log_warn "Symlink check failed for: $link. It might not be linked correctly to your dotfiles."
        VERIFICATION_STATUS="WARNING"
    fi
done

# 6. Generate Installation Report
log_info "--- Installation Report ---"
log_info "Overall Status: ${VERIFICATION_STATUS}"
if [[ "$VERIFICATION_STATUS" == "WARNING" ]]; then
    log_warn "Some warnings were detected. Please review the logs above."
fi
log_info "Phase 06 completed: Verification checks performed."

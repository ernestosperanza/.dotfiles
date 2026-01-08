#!/bin/bash
# bootstrap.sh
# Main orchestration script for dotfiles setup.

set -euo pipefail

# --- Configuration ---
INSTALL_DIR="${HOME}/.dotfiles/install"
LOG_FILE="${HOME}/.dotfiles/bootstrap_log_$(date +%Y%m%d_%H%M%S).log"

# --- Variables ---
DRY_RUN=false
SKIPPED_PHASES=""
PHASES=(
    "00_preflight"
    "01_packages"
    "02_stow"
    "03_macos"
    "04_secrets"
    "05_apps"
    "06_verify"
)

# --- Helper Functions ---
log_info() {
    echo "$(date +'%H:%M:%S') INFO: $1" | tee -a "$LOG_FILE"
}

log_warn() {
    echo "$(date +'%H:%M:%S') WARN: $1" | tee -a "$LOG_FILE" >&2
}

log_error() {
    echo "$(date +'%H:%M:%S') ERROR: $1" | tee -a "$LOG_FILE" >&2
    exit 1
}

# --- Argument Parsing ---
parse_args() {
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            --dry-run)
                DRY_RUN=true
                log_info "Dry-run mode activated. No changes will be applied."
                ;;
            --skip-phases=*)
                SKIPPED_PHASES=$(echo "$1" | cut -d'=' -f2 | tr ',' ' ') # Replace commas with spaces for easy matching
                log_info "Skipping phases: ${SKIPPED_PHASES}"
                ;;
            *)
                log_error "Unknown argument: $1"
                ;;
        esac
        shift
    done
}

# --- Phase Execution ---
execute_phase() {
    local phase_name="$1"
    local phase_script="${INSTALL_DIR}/${phase_name}.sh"
    local phase_number=$(echo "$phase_name" | cut -d'_' -f1)

    log_info "--- Executing Phase ${phase_number}: ${phase_name//_/-} ---"

    # Check if phase should be skipped
    for skipped in $SKIPPED_PHASES; do
        if [[ "$phase_number" == "$skipped" ]]; then
            log_info "Skipping phase ${phase_number} as requested."
            return 0
        fi
    done

    # Check if script exists and is executable
    if [[ ! -f "$phase_script" ]]; then
        log_error "Phase script not found: ${phase_script}. Please ensure it exists."
    fi
    if [[ ! -x "$phase_script" ]]; then
        log_warn "Phase script ${phase_script} is not executable. Making it executable."
        chmod +x "$phase_script" || log_error "Failed to make ${phase_script} executable."
    fi

    if [[ "$DRY_RUN" == true ]]; then
        log_info "[DRY RUN] Would execute: ${phase_script}"
    else
        log_info "Executing: ${phase_script}"
        "$phase_script"
        if [[ "$?" -ne 0 ]]; then # Check the exit code of the executed script
            log_error "Phase ${phase_number} (${phase_name}) failed. Aborting bootstrap."
        fi
    fi

    log_info "--- Phase ${phase_number} completed. ---"
}

# --- Main Execution ---

# Ensure log directory exists
mkdir -p "$(dirname "$LOG_FILE")"

log_info "Starting dotfiles bootstrap process."

parse_args "$@"

for phase in "${PHASES[@]}"; do
    execute_phase "$phase"
done

log_info "Dotfiles bootstrap process completed."
log_info "Review the log file for details: ${LOG_FILE}"

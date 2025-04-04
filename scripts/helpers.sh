#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# File: helpers.sh
# Author: Ravishankar Sivasubramaniam (based on run_all.sh)
# Description: Defines common helper functions for logging and output
#              formatting in setup scripts.
# -----------------------------------------------------------------------------

# --- Colors (from run_all.sh) ---
C_RESET='\033[0m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[0;33m'
C_BLUE='\033[0;34m'
C_MAGENTA='\033[0;35m'
C_CYAN='\033[0;36m'
C_BOLD='\033[1m'
C_DIM='\033[2m'

# --- Logging Functions ---

# Prints a bold, cyan header message.
# Usage: header "Setting up Git"
header() {
    echo -e "\n${C_BOLD}${C_CYAN}--- $1 ---${C_RESET}"
}

# Prints an informational message with a blue arrow.
# Usage: info "Cloning repository..."
info() {
    echo -e "${C_BLUE}➡️  $1${C_RESET}"
}

# Prints a success message with a green checkmark.
# Usage: success "Git configured."
success() {
    echo -e "${C_GREEN}✅ $1${C_RESET}"
}

# Prints a warning message in yellow.
# Usage: warn "File already exists, skipping."
warn() {
    echo -e "${C_YELLOW}⚠️  $1${C_RESET}"
}

# Prints an error message in red and exits if needed (optional second arg).
# Usage: error "Failed to install package."
# Usage: error "Critical failure." 1 # Exits with status 1
error() {
    echo -e "${C_RED}❌ Error: $1${C_RESET}" >&2
    if [ "$2" -eq 1 ]; then
        exit 1
    fi
}

# Add other helper functions as needed, e.g., for user prompts:
# prompt_confirm() { ... }


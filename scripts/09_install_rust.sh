#!/usr/bin/env bash
set -e # Exit immediately if a command exits with a non-zero status.
# set -x # Uncomment for debugging

# -----------------------------------------------------------------------------
# Script: 09_install_rust.sh
# Author: Ravishankar Sivasubramaniam
# Description: Installs Rust using the official rustup toolchain manager
#              and installs the mdBook utility using cargo.
# -----------------------------------------------------------------------------

# Source the helper functions
# Assuming helpers.sh is in the SAME directory as this script
# shellcheck disable=SC1091
source "$(dirname "$0")/helpers.sh" # <-- CORRECTED PATH ASSUMPTION

# --- Install Rust via rustup ---
header "Installing Rust via rustup"
if command -v rustup &> /dev/null; then
    info "Rust (rustup) is already installed. Updating..."
    rustup update
else
    info "Rustup not found. Installing Rust..."
    # Download and run the rustup installer script non-interactively
    # See: https://rust-lang.github.io/rustup/installation/other.html
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

    # Source the cargo environment script to make cargo available in this session
    # Note: User might need to restart their shell or run this manually after the script finishes
    if [ -f "$HOME/.cargo/env" ]; then
        # shellcheck disable=SC1090
        source "$HOME/.cargo/env"
        info "Sourced cargo environment variables."
    else
        warn "Could not find $HOME/.cargo/env. Please ensure Rust is correctly added to your PATH."
        warn "You might need to restart your terminal or run 'source \$HOME/.cargo/env'."
    fi
fi

# Verify cargo is available
if ! command -v cargo &> /dev/null; then
    error "Cargo command not found after installation attempt. Cannot install mdbook."
    error "Please ensure Rust is correctly installed and added to your PATH."
    exit 1
fi
success "Rust installation/update complete."

# --- Install mdBook ---
header "Installing/Updating mdBook"
if command -v mdbook &> /dev/null; then
    info "mdBook already installed. Checking for updates (via cargo install)..."
else
    info "Installing mdBook..."
fi

# Use cargo install - it handles installation and updates
# Using --locked might prevent updates if Cargo.lock changes significantly,
# but ensures reproducibility. Remove --locked if you always want the latest compatible version.
cargo install mdbook --locked --version ^0.4

if command -v mdbook &> /dev/null; then
    success "mdBook installed/updated successfully (`mdbook --version`)."
else
    error "mdBook installation failed."
    exit 1
fi

echo ""
info "Rust and mdBook setup script finished."


#!/usr/bin/env bash
set -e # Exit immediately if a command exits with a non-zero status.

# ... (rest of script 02 content, no significant changes needed besides set -e and warnings) ...
# -----------------------------------------------------------------------------
# Script: 02_install_brew_core.sh
# Author: Ravishankar Sivasubramaniam
# Description: Installs essential command-line tools using Homebrew.
# -----------------------------------------------------------------------------

echo "----------------------------------------"
echo "Starting Core Homebrew Packages Installation..."
echo "----------------------------------------"
print_message() { echo "➡️  $1"; }
if ! command -v brew &> /dev/null; then echo "❌ Error: Homebrew not found."; exit 1; fi

print_message "Updating Homebrew repository..."
brew update || echo "⚠️ Warning: brew update encountered issues. Continuing..."

CORE_PACKAGES=( "coreutils" "mas" "moreutils" "findutils" "gnu-sed" "bash" "bash-completion@2" "gnupg" "vim" "grep" "ripgrep" "git" "git-lfs" "ssh-copy-id" "tree" "node" "wget" "htop" "zsh" "zsh-syntax-highlighting" "autojump" "zsh-autosuggestions" "dockutil" "rename" )

print_message "Installing core Homebrew packages..."
for pkg in "${CORE_PACKAGES[@]}"; do
  if brew list --formula | grep -q "^${pkg}$"; then print_message "${pkg} already installed."; else
    print_message "Installing ${pkg}..."
    brew install "${pkg}" || echo "⚠️ Warning: Failed to install ${pkg}. Continuing..."
  fi
done

print_message "Upgrading existing Homebrew packages..."
brew upgrade || echo "⚠️ Warning: brew upgrade encountered issues."
print_message "Cleaning up old Homebrew package versions..."
brew cleanup || echo "⚠️ Warning: brew cleanup encountered issues."

echo "----------------------------------------"
echo "Core Homebrew Packages Installation Complete."
echo "----------------------------------------"
exit 0

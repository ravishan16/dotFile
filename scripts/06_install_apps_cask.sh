#!/usr/bin/env bash
set -e # Exit immediately if a command exits with a non-zero status.

# -----------------------------------------------------------------------------
# Script: 06_install_apps_cask.sh
# Author: Ravishankar Sivasubramaniam
# Description: Installs GUI applications using Homebrew Cask.
# -----------------------------------------------------------------------------

echo "----------------------------------------"
echo "Starting GUI Application Installation (Homebrew Cask)..."
echo "----------------------------------------"
print_message() { echo "➡️  $1"; }
if ! command -v brew &> /dev/null; then echo "❌ Error: Homebrew not found."; exit 1; fi

print_message "Updating Homebrew repository (includes Casks)..."
brew update || echo "⚠️ Warning: brew update encountered issues. Continuing..."

CASK_PACKAGES=(  "google-chrome" "raycast" "visual-studio-code" "iterm2" "warp" "ngrok" "dbeaver-community" "postman" "zoom" "discord" "microsoft-teams" "bitwarden" "ollama" "dropbox" "google-drive" "cheatsheet" "keycastr" "itsycal" "suspicious-package" "webpquicklook" "betterzip" )

print_message "Installing Homebrew Cask applications..."
for cask in "${CASK_PACKAGES[@]}"; do
  if brew list --cask | grep -q "^${cask}$"; then print_message "${cask} already installed."; else
    print_message "Installing ${cask}..."
    # Add --no-quarantine for potentially faster/smoother installs, use with caution
    brew install --cask --no-quarantine "${cask}" || echo "⚠️ Warning: Failed to install ${cask}. Continuing..."
  fi
done

print_message "Cleaning up old Homebrew Cask versions..."
brew cleanup || echo "⚠️ Warning: brew cleanup encountered issues."

echo "----------------------------------------"
echo "GUI Application Installation Complete."
echo "----------------------------------------"
exit 0

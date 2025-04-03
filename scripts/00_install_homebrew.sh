#!/usr/bin/env bash
set -e # Exit immediately if a command exits with a non-zero status.

# ... (rest of script 00 content, no significant changes needed besides set -e) ...
# -----------------------------------------------------------------------------
# Script: 00_install_homebrew.sh
# Author: Ravishankar Sivasubramaniam
# Description: Installs Homebrew package manager if not already installed,
#              ensures it's in the PATH, and runs basic checks.
# -----------------------------------------------------------------------------

echo "----------------------------------------"
echo "Starting Homebrew Setup..."
echo "----------------------------------------"

# Function to print messages
print_message() {
  echo "➡️  $1"
}

# Check if Homebrew is installed
if command -v brew &> /dev/null; then
  print_message "Homebrew is already installed."
else
  print_message "Homebrew not found. Installing Homebrew..."
  # Check for Xcode Command Line Tools first (needed by Homebrew installer)
  if ! xcode-select -p &> /dev/null; then
      echo "Xcode Command Line Tools not found. Attempting to install..."
      xcode-select --install
      echo "Please follow the prompts to install Xcode Command Line Tools, then re-run this script."
      exit 1 # Exit, requires user interaction
  fi
  # Install Homebrew using the official script
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  print_message "Homebrew installed successfully."

  # Add Homebrew to PATH (Installer usually does this, but explicit fallback)
  print_message "Adding Homebrew to your PATH (if needed)..."
  if [[ "$(uname -m)" == "arm64" ]]; then BREW_PREFIX="/opt/homebrew"; else BREW_PREFIX="/usr/local"; fi
  eval "$(${BREW_PREFIX}/bin/brew shellenv)"
  CURRENT_SHELL=$(basename "$SHELL")
  if [[ "$CURRENT_SHELL" == "zsh" ]]; then PROFILE_FILE="$HOME/.zprofile"; elif [[ "$CURRENT_SHELL" == "bash" ]]; then if [[ -f "$HOME/.bash_profile" ]]; then PROFILE_FILE="$HOME/.bash_profile"; else PROFILE_FILE="$HOME/.profile"; fi; else PROFILE_FILE="$HOME/.profile"; fi
  if ! grep -q 'eval "$('${BREW_PREFIX}'/bin/brew shellenv)"' "$PROFILE_FILE" 2>/dev/null; then
    echo "Adding brew shellenv to ${PROFILE_FILE}..."
    echo >> "$PROFILE_FILE"; echo 'eval "$('${BREW_PREFIX}'/bin/brew shellenv)"' >> "$PROFILE_FILE"
  fi
  print_message "Homebrew added to PATH for current and future sessions."
fi

# --- Post-Installation/Verification ---
print_message "Updating Homebrew..."
brew update || echo "⚠️ Warning: brew update encountered issues."
print_message "Running brew doctor..."
brew doctor || echo "⚠️ Warning: brew doctor reported issues. Please review the output above."

echo "----------------------------------------"
echo "Homebrew Setup Complete."
echo "----------------------------------------"
exit 0

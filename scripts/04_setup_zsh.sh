#!/usr/bin/env bash
set -e # Exit immediately if a command exits with a non-zero status.

# -----------------------------------------------------------------------------
# Script: 04_setup_zsh.sh
# Author: Ravishankar Sivasubramaniam
# Description: Installs Oh My Zsh, theme, plugins. Symlinks configs from ../dot/.
#              Sets Zsh as default shell.
# -----------------------------------------------------------------------------

echo "----------------------------------------"
echo "Starting Zsh Setup (Symlink Version)..."
echo "----------------------------------------"
print_message() { echo "➡️  $1"; }

# --- Determine Directories ---
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
REPO_ROOT_DIR=$(cd "${SCRIPT_DIR}/.." &> /dev/null && pwd) # Assumes scripts are in scripts/ subdir
DOT_DIR="${REPO_ROOT_DIR}/dot"

print_message "Repo root directory: ${REPO_ROOT_DIR}"
print_message "Dotfile source directory: ${DOT_DIR}"

# --- Check Prerequisites ---
if ! command -v git &> /dev/null; then echo "❌ Error: Git not found."; exit 1; fi
if ! command -v zsh &> /dev/null; then echo "❌ Error: Zsh not found."; exit 1; fi

# --- Install Oh My Zsh ---
if [ -d "$HOME/.oh-my-zsh" ]; then print_message "Oh My Zsh already installed."; else
  print_message "Installing Oh My Zsh..."; sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  print_message "Oh My Zsh installed successfully."
fi

# --- Setup Oh My Zsh Custom Directory ---
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
mkdir -p "$ZSH_CUSTOM/themes" "$ZSH_CUSTOM/plugins"

# --- Install Powerlevel10k Theme ---
P10K_DIR="${ZSH_CUSTOM}/themes/powerlevel10k"
if [ -d "$P10K_DIR" ]; then print_message "Powerlevel10k theme exists."; else
  print_message "Cloning Powerlevel10k theme..."; git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR" || echo "⚠️ Failed clone P10k"
fi

# --- Install Zsh Plugins ---
ZSH_PLUGINS_DIR="${ZSH_CUSTOM}/plugins"
AUTOSUGG_DIR="${ZSH_PLUGINS_DIR}/zsh-autosuggestions"
if [ -d "$AUTOSUGG_DIR" ]; then print_message "zsh-autosuggestions exists."; else
  print_message "Cloning zsh-autosuggestions..."; git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTOSUGG_DIR" || echo "⚠️ Failed clone autosuggestions"
fi
SYNTAX_DIR="${ZSH_PLUGINS_DIR}/zsh-syntax-highlighting"
if [ -d "$SYNTAX_DIR" ]; then print_message "zsh-syntax-highlighting exists."; else
  print_message "Cloning zsh-syntax-highlighting..."; git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$SYNTAX_DIR" || echo "⚠️ Failed clone syntax"
fi

# --- Symlink Zsh Configuration Files ---
print_message "Setting up Zsh configuration symlinks..."
setup_symlink() {
    local filename="$1"; source_file="${DOT_DIR}/${filename}"; target_file="$HOME/${filename}"
    if [ ! -f "$source_file" ]; then echo "⚠️ Warning: ${source_file} not found. Skipping link."; return; fi
    print_message "Linking ${target_file} -> ${source_file}"
    rm -f "$target_file"; ln -s "$source_file" "$target_file"
    print_message "Symlink for ${filename} created."
}
setup_symlink ".zshrc"
setup_symlink ".p10k.zsh"
setup_symlink ".aliases"
setup_symlink ".functions"

# --- Set Zsh as Default Shell ---
print_message "Setting Zsh as default shell..."
if [[ "$(uname -m)" == "arm64" ]]; then BREW_ZSH_PATH="/opt/homebrew/bin/zsh"; else BREW_ZSH_PATH="/usr/local/bin/zsh"; fi
if [ ! -f "$BREW_ZSH_PATH" ]; then echo "❌ Error: Brew Zsh not found at ${BREW_ZSH_PATH}."; exit 1; fi
if [[ "$SHELL" == "$BREW_ZSH_PATH" ]]; then print_message "Zsh (${BREW_ZSH_PATH}) is already default."; else
    print_message "Attempting to set ${BREW_ZSH_PATH} as default."
    if ! grep -Fxq "$BREW_ZSH_PATH" /etc/shells; then print_message "Adding ${BREW_ZSH_PATH} to /etc/shells (sudo)..."; echo "$BREW_ZSH_PATH" | sudo tee -a /etc/shells; fi
    if grep -Fxq "$BREW_ZSH_PATH" /etc/shells; then print_message "Changing default shell via chsh (password)..."; chsh -s "$BREW_ZSH_PATH"; print_message "Default shell change requested. Restart terminal or log out/in."; else echo "❌ Error: Failed to add Zsh to /etc/shells."; exit 1; fi
fi

echo "----------------------------------------"
echo "Zsh Setup Complete (Symlink Version)."
echo "Ensure your dot/.zshrc correctly lists plugins and your dot/.p10k.zsh is configured."
echo "Please restart your terminal or log out/in for changes to take effect."
echo "----------------------------------------"
exit 0

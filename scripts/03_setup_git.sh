#!/usr/bin/env bash
set -e # Exit immediately if a command exits with a non-zero status.

# -----------------------------------------------------------------------------
# Script: 03_setup_git.sh
# Author: Ravishankar Sivasubramaniam
# Description: Configures basic Git settings, sourcing user info from ../.env
#              if available, prompting otherwise. Symlinks global .gitignore
#              from the repo's ../dot/ folder.
# -----------------------------------------------------------------------------

echo "----------------------------------------"
echo "Starting Git Setup (Revised)..."
echo "----------------------------------------"
print_message() { echo "➡️  $1"; }

# --- Determine Directories ---
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
REPO_ROOT_DIR=$(cd "${SCRIPT_DIR}/.." &> /dev/null && pwd) # Assumes scripts are in scripts/ subdir
DOT_DIR="${REPO_ROOT_DIR}/dot"
ENV_FILE="${REPO_ROOT_DIR}/.env"

print_message "Repo root directory: ${REPO_ROOT_DIR}"
print_message "Dotfile source directory: ${DOT_DIR}"
print_message ".env file expected at: ${ENV_FILE}"


# --- Source .env file ---
if [ -f "$ENV_FILE" ]; then
  print_message "Sourcing configuration from ${ENV_FILE}..."
  set -a; source "$ENV_FILE"; set +a
else
  print_message "Warning: ${ENV_FILE} not found. Will prompt for required values."
fi

# --- Ensure Git is available ---
if ! command -v git &> /dev/null; then echo "❌ Error: Git not found."; exit 1; fi

# --- Configure Git User Information ---
print_message "Configuring global Git user information..."
configured_name=false
if [ -n "$GIT_AUTHOR_NAME" ]; then git config --global user.name "$GIT_AUTHOR_NAME"; print_message "Git user.name set from .env."; configured_name=true; fi
if ! $configured_name && [ -z "$(git config --global --get user.name)" ]; then read -p "👤 Enter Git user name: " git_prompt; git config --global user.name "$git_prompt"; print_message "Git user.name set via prompt."; else print_message "Git user.name already configured or set from .env."; fi

configured_email=false
if [ -n "$GIT_AUTHOR_EMAIL" ]; then git config --global user.email "$GIT_AUTHOR_EMAIL"; print_message "Git user.email set from .env."; configured_email=true; fi
if ! $configured_email && [ -z "$(git config --global --get user.email)" ]; then read -p "✉️ Enter Git user email: " git_prompt; git config --global user.email "$git_prompt"; print_message "Git user.email set via prompt."; else print_message "Git user.email already configured or set from .env."; fi

# --- Symlink Global .gitignore ---
print_message "Setting up global .gitignore symlink..."
SOURCE_GITIGNORE="${DOT_DIR}/.gitignore_global"
TARGET_GITIGNORE="$HOME/.gitignore_global"
if [ ! -f "$SOURCE_GITIGNORE" ]; then echo "⚠️ Warning: ${SOURCE_GITIGNORE} not found. Skipping."; else
  print_message "Linking ${TARGET_GITIGNORE} -> ${SOURCE_GITIGNORE}"
  rm -f "$TARGET_GITIGNORE"; ln -s "$SOURCE_GITIGNORE" "$TARGET_GITIGNORE"
  git config --global core.excludesfile "$TARGET_GITIGNORE"
  print_message "Symlink created and Git configured."
fi

# --- Other Common Git Configurations ---
print_message "Applying other common Git configurations..."
git config --global init.defaultBranch main
git config --global color.ui auto
print_message "Set default branch (main) and color UI."

echo "----------------------------------------"
echo "Git Setup Complete (Revised)."
echo "----------------------------------------"
exit 0

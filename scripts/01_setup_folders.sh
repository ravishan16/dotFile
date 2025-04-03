#!/usr/bin/env bash
set -e # Exit immediately if a command exits with a non-zero status.

# -----------------------------------------------------------------------------
# Script: 01_setup_folders.sh
# Author: Ravishankar Sivasubramaniam
# Description: Creates standard project and development directories, including
#              GIT_HOME defined in ../.env. Asks for confirmation first.
# -----------------------------------------------------------------------------

echo "----------------------------------------"
echo "Starting Folder Setup..."
echo "----------------------------------------"
print_message() { echo "➡️  $1"; }

# --- Determine Directories ---
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
REPO_ROOT_DIR=$(cd "${SCRIPT_DIR}/.." &> /dev/null && pwd) # Assumes scripts are in scripts/ subdir
ENV_FILE="${REPO_ROOT_DIR}/.env"

# --- Source .env file ---
GIT_HOME_DEFAULT="$HOME/Projects" # Default if .env or var is missing
if [ -f "$ENV_FILE" ]; then
  print_message "Sourcing configuration from ${ENV_FILE}..."
  set -a; source "$ENV_FILE"; set +a
else
  # Adjusted warning message for clarity
  print_message "Warning: ${ENV_FILE} (in repository root) not found. Using default GIT_HOME: ${GIT_HOME_DEFAULT}"
fi
# Use sourced GIT_HOME or default
GIT_HOME="${GIT_HOME:-$GIT_HOME_DEFAULT}"

# --- Define Directories to Create ---
# Ensure paths are relative to $HOME if they don't start with /
GIT_HOME_REL="${GIT_HOME#$HOME/}"
DIRECTORIES_TO_PROCESS=() # Use a different name for the final list

if [[ "$GIT_HOME_REL" == "$GIT_HOME" ]] && [[ "$GIT_HOME" != "$HOME" ]]; then
    # GIT_HOME is outside HOME, treat as absolute path
    echo "⚠️ Warning: GIT_HOME (${GIT_HOME}) is outside \$HOME."
    DIRECTORIES_TO_PROCESS+=( "$GIT_HOME" ) # Add absolute GIT_HOME
else
    # Standard case: GIT_HOME is relative to $HOME
     DIRECTORIES_TO_PROCESS+=( "$HOME/$GIT_HOME_REL" ) # Add absolute path derived from relative
     # Also add the dotfiles dir inside GIT_HOME, assuming that's where the repo lives
     # This path might already exist if the user cloned correctly.
     DIRECTORIES_TO_PROCESS+=( "$HOME/${GIT_HOME_REL}/dotFile" )
fi
# Always add the standard Code directory relative to HOME
DIRECTORIES_TO_PROCESS+=( "$HOME/Code" )

# --- Confirmation Step ---
echo ""
print_message "The following directories will be checked/created:"
for dir_path in "${DIRECTORIES_TO_PROCESS[@]}"; do
    echo "  - ${dir_path}"
done
echo ""
read -p "Proceed with creating/checking these directories? (y/N): " confirm_create
echo "" # Newline after prompt

if [[ ! "$confirm_create" =~ ^[Yy]$ ]]; then
    echo "🛑 Aborting directory creation."
    exit 0 # Exit gracefully without error
fi

# --- Directory Creation Loop ---
print_message "Creating standard directories (including GIT_HOME: ${GIT_HOME})..."
for full_path in "${DIRECTORIES_TO_PROCESS[@]}"; do
  # Path is already absolute here
  if [ -d "$full_path" ]; then
      print_message "Directory already exists: ${full_path}"
  else
    # Create the directory, including parent directories if necessary (-p)
    mkdir -p "$full_path"
    print_message "Created directory: ${full_path}"
  fi
done

echo "----------------------------------------"
echo "Folder Setup Complete."
echo "----------------------------------------"
exit 0

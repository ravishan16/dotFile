#!/usr/bin/env bash
set -e # Exit immediately if a command exits with a non-zero status.

# -----------------------------------------------------------------------------
# Script: 08_setup_ssh_github.sh
# Author: Ravishankar Sivasubramaniam
# Description: Checks for/generates SSH keys (ED25519 preferred), configures
#              SSH for GitHub (without UseKeychain), and instructs user
#              to add public key to GitHub.
# -----------------------------------------------------------------------------

echo "----------------------------------------"
echo "Starting SSH Key Setup for GitHub..."
echo "----------------------------------------"
print_message() { echo "➡️  $1"; }

# --- Determine Directories ---
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
REPO_ROOT_DIR=$(cd "${SCRIPT_DIR}/.." &> /dev/null && pwd) # Assumes scripts are in scripts/ subdir
ENV_FILE="${REPO_ROOT_DIR}/.env"

# --- Source .env file for email ---
GIT_AUTHOR_EMAIL="" # Default empty
if [ -f "$ENV_FILE" ]; then print_message "Sourcing configuration from ${ENV_FILE}..."; set -a; source "$ENV_FILE"; set +a; else print_message "Warning: ${ENV_FILE} not found."; fi

# --- Check/Generate SSH Key ---
SSH_DIR="$HOME/.ssh"; KEY_PATH_ED25519="${SSH_DIR}/id_ed25519"; KEY_PATH_RSA="${SSH_DIR}/id_rsa"; KEY_TO_ADD=""
mkdir -p "$SSH_DIR"; chmod 700 "$SSH_DIR"
if [ -f "$KEY_PATH_ED25519" ]; then print_message "Existing ED25519 key found: ${KEY_PATH_ED25519}."; PUB_KEY_PATH="${KEY_PATH_ED25519}.pub"; KEY_TO_ADD="$KEY_PATH_ED25519";
elif [ -f "$KEY_PATH_RSA" ]; then print_message "Existing RSA key found: ${KEY_PATH_RSA}."; PUB_KEY_PATH="${KEY_PATH_RSA}.pub"; KEY_TO_ADD="$KEY_PATH_RSA";
else
    print_message "No existing SSH key found. Generating new ED25519 key..."
    if [ -z "$GIT_AUTHOR_EMAIL" ]; then read -p "✉️ Enter email for SSH key comment: " key_email; else key_email="$GIT_AUTHOR_EMAIL"; print_message "Using email from .env: ${key_email}"; fi
    echo "--------------------------------------------------------------------"; echo "⚠️ Generating SSH key without passphrase."; echo "   For higher security, generate manually: ssh-keygen -t ed25519 -C \"${key_email}\""; echo "--------------------------------------------------------------------"
    ssh-keygen -t ed25519 -C "$key_email" -f "$KEY_PATH_ED25519" -N ""
    print_message "Generated new ED25519 key: ${KEY_PATH_ED25519}"; PUB_KEY_PATH="${KEY_PATH_ED25519}.pub"; KEY_TO_ADD="$KEY_PATH_ED25519"
fi

# --- Configure SSH Agent and Config ---
CONFIG_PATH="${SSH_DIR}/config"; print_message "Configuring SSH config (${CONFIG_PATH})..."
touch "$CONFIG_PATH"; chmod 600 "$CONFIG_PATH"
CONFIG_KEY_PATH="${KEY_TO_ADD:-$KEY_PATH_ED25519}" # Default to ED25519 path if KEY_TO_ADD is somehow empty

if grep -q "Host github.com" "$CONFIG_PATH"; then print_message "SSH config entry for github.com already exists."; else
    print_message "Adding github.com configuration to ${CONFIG_PATH}..."
    # Add recommended settings for GitHub, REMOVING UseKeychain
    cat << EOF >> "$CONFIG_PATH"

Host github.com
  AddKeysToAgent yes
  # UseKeychain yes # Removed - Caused 'Bad configuration option' error
  IdentityFile ${CONFIG_KEY_PATH}
EOF
    print_message "Added github.com config entry (without UseKeychain)."
fi

# --- Start ssh-agent and add key ---
print_message "Attempting to add SSH key to agent..."
eval "$(ssh-agent -s)" > /dev/null # Start agent quietly
ssh-add "${KEY_TO_ADD}" || echo "⚠️ Warning: ssh-add failed. Key might already be added or requires passphrase."

# --- Instruct User to Add Key to GitHub ---
if [ -f "$PUB_KEY_PATH" ]; then
    echo ""; echo "--------------------------------------------------------------------"; echo "✅ ACTION REQUIRED: Add SSH Key to GitHub"; echo "--------------------------------------------------------------------"
    echo "1. Copy your public SSH key below:"; echo ""; cat "$PUB_KEY_PATH"; echo ""
    echo "2. Go to GitHub > Settings > SSH and GPG keys > New SSH key."; echo "   ( https://github.com/settings/keys )"
    echo "3. Paste the copied key into the 'Key' field, give it a title (e.g., 'My New Mac'), and click 'Add SSH key'."
    echo "--------------------------------------------------------------------"
else echo "❌ Error: Could not find public key file at ${PUB_KEY_PATH}."; fi

echo "----------------------------------------"
echo "SSH Key Setup for GitHub Complete."
echo "Remember to add the public key to your GitHub account online!"
echo "----------------------------------------"
exit 0

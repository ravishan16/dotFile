#!/usr/bin/env bash
set -e # Exit immediately if a command exits with a non-zero status.
# set -x # Uncomment for debugging

# -----------------------------------------------------------------------------
# Script: 08_setup_ssh_github.sh
# Author: Ravishankar Sivasubramaniam
# Description: Checks for/generates SSH keys (ED25519 preferred), configures
#              SSH for GitHub (without UseKeychain), and instructs user
#              to add public key to GitHub. Includes guidance for manual
#              key generation with passphrase.
# -----------------------------------------------------------------------------

echo "----------------------------------------"
echo "Starting SSH Key Setup for GitHub..."
echo "----------------------------------------"

# --- Helper Functions ---
print_message() {
  # Print message in blue
  echo -e "\033[0;34m➡️  $1\033[0m"
}
print_warning() {
  # Print warning message in yellow
  echo -e "\033[0;33m⚠️ Warning: $1\033[0m"
}
print_error() {
  # Print error message in red
  echo -e "\033[0;31m❌ Error: $1\033[0m" >&2 # Print to stderr
}
print_success() {
  # Print success message in green
  echo -e "\033[0;32m✅ $1\033[0m"
}

# --- Determine Directories ---
# Get the directory where the script is located
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
# Get the root directory of the repository (assuming scripts/ is one level down)
REPO_ROOT_DIR=$(cd "${SCRIPT_DIR}/.." &> /dev/null && pwd)
# Path to the .env file in the repository root
ENV_FILE="${REPO_ROOT_DIR}/.env"

# --- Source .env file for email ---
GIT_AUTHOR_EMAIL="" # Default empty
if [ -f "$ENV_FILE" ]; then
  print_message "Sourcing configuration from ${ENV_FILE}..."
  # Source the .env file, making variables available
  set -a # Automatically export all variables defined after this
  source "$ENV_FILE"
  set +a # Stop automatically exporting variables
else
  print_warning "${ENV_FILE} not found. Will prompt for email if needed."
fi

# --- Check/Generate SSH Key ---
SSH_DIR="$HOME/.ssh"
KEY_PATH_ED25519="${SSH_DIR}/id_ed25519"
KEY_PATH_RSA="${SSH_DIR}/id_rsa" # Legacy key type check
KEY_TO_USE="" # Variable to store the path of the key we will use/configure
PUB_KEY_PATH="" # Variable to store the path of the public key

# Ensure the .ssh directory exists and has correct permissions
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"
print_message "Checked/Created SSH directory: ${SSH_DIR}"

# Check for existing keys, preferring ED25519
if [ -f "$KEY_PATH_ED25519" ] && [ -f "${KEY_PATH_ED25519}.pub" ]; then
  print_message "Existing ED25519 key found: ${KEY_PATH_ED25519}"
  KEY_TO_USE="$KEY_PATH_ED25519"
  PUB_KEY_PATH="${KEY_PATH_ED25519}.pub"
elif [ -f "$KEY_PATH_RSA" ] && [ -f "${KEY_PATH_RSA}.pub" ]; then
  print_warning "Found legacy RSA key: ${KEY_PATH_RSA}. ED25519 is recommended."
  KEY_TO_USE="$KEY_PATH_RSA"
  PUB_KEY_PATH="${KEY_PATH_RSA}.pub"
else
  # No suitable key found, generate a new ED25519 key
  print_message "No existing suitable SSH key found (checked for id_ed25519 and id_rsa)."

  # Get email for the key comment
  key_email=""
  if [ -n "$GIT_AUTHOR_EMAIL" ]; then
      key_email="$GIT_AUTHOR_EMAIL"
      print_message "Using email from .env for SSH key comment: ${key_email}"
  else
      read -p "✉️ Enter email address to associate with the new SSH key: " key_email
      # Basic validation (presence check)
      if [ -z "$key_email" ]; then
          print_error "Email address cannot be empty."
          exit 1
      fi
  fi

  # Provide instructions and choice for passphrase
  echo ""
  echo -e "\033[0;33m--------------------------------------------------------------------\033[0m"
  echo -e "\033[0;33mThis script can generate a new ED25519 SSH key for you.\033[0m"
  echo -e "\033[0;33mGenerating WITHOUT a passphrase is convenient but LESS SECURE.\033[0m"
  echo -e "\033[0;33mFor higher security, generate the key manually WITH a passphrase:\033[0m"
  echo -e "\033[0;33m  1. Press Ctrl+C now to cancel this script.\033[0m"
  echo -e "\033[0;33m  2. Run this command in your terminal:\033[0m"
  echo -e "\033[0;33m     \033[1mssh-keygen -t ed25519 -C \"${key_email}\"\033[0m"
  echo -e "\033[0;33m  3. When prompted, enter a secure passphrase (and confirm it).\033[0m"
  echo -e "\033[0;33m  4. Re-run this setup script (it will detect the manually created key),\033[0m"
  echo -e "\033[0;33m     or manually configure your SSH config and add the key to the agent.\033[0m"
  echo -e "\033[0;33m--------------------------------------------------------------------\033[0m"
  # Prompt user to continue or cancel
  read -p "➡️ Press Enter to generate the key WITHOUT a passphrase, or Ctrl+C to cancel: " confirm_generate

  # Generate the key without a passphrase using -N ""
  print_message "Generating new ED25519 key at ${KEY_PATH_ED25519}..."
  ssh-keygen -t ed25519 -C "$key_email" -f "$KEY_PATH_ED25519" -N "" # -N "" specifies no passphrase

  # Check if key generation was successful
  if [ $? -ne 0 ] || [ ! -f "$KEY_PATH_ED25519" ] || [ ! -f "${KEY_PATH_ED25519}.pub" ]; then
      print_error "SSH key generation failed."
      exit 1
  fi

  print_success "Generated new ED25519 key (without passphrase)."
  KEY_TO_USE="$KEY_PATH_ED25519"
  PUB_KEY_PATH="${KEY_PATH_ED25519}.pub"
fi

# --- Configure SSH Agent and Config ---
CONFIG_PATH="${SSH_DIR}/config"
print_message "Configuring SSH config file (${CONFIG_PATH})..."

# Ensure the config file exists and has correct permissions
touch "$CONFIG_PATH"
chmod 600 "$CONFIG_PATH"

# Check if the specific key path is already configured for github.com
# This is a basic check; more robust parsing might be needed for complex configs
if grep -q "Host github.com" "$CONFIG_PATH" && grep -q "IdentityFile ${KEY_TO_USE}" "$CONFIG_PATH"; then
  print_message "SSH config entry for github.com with key ${KEY_TO_USE} seems to exist."
else
  print_message "Adding/Updating github.com configuration in ${CONFIG_PATH}..."
  # Check if Host github.com entry already exists to avoid duplicates
  if grep -q "Host github.com" "$CONFIG_PATH"; then
      print_warning "Host github.com entry exists, ensure IdentityFile is correct or update manually."
      # Optionally, could attempt to replace the IdentityFile line if needed
  else
      # Add recommended settings for GitHub
      # UseKeychain is often problematic/deprecated with modern ssh-agent setups, so omitted.
      # AddKeysToAgent yes is generally preferred.
      cat << EOF >> "$CONFIG_PATH"

Host github.com
  HostName github.com
  User git
  AddKeysToAgent yes
  IdentityFile ${KEY_TO_USE}
  # IdentitiesOnly yes # Uncomment if you want to prevent offering other keys
EOF
      print_success "Added github.com config entry to ${CONFIG_PATH}."
  fi
fi

# --- Start ssh-agent and add key ---
# Check if ssh-agent is running, start if not
print_message "Checking and ensuring ssh-agent is running..."
eval "$(ssh-agent -s)" > /dev/null # Start agent quietly if not running, update env vars if it is

# Add the key to the agent. Use ssh-add.
# The -K option (add to keychain) is macOS specific and often redundant/problematic
# with AddKeysToAgent=yes in config. Standard ssh-add is usually sufficient.
print_message "Attempting to add SSH key (${KEY_TO_USE}) to the agent..."
ssh-add "${KEY_TO_USE}" # Add the key

# Check the exit status of ssh-add
if [ $? -ne 0 ]; then
    # Common reasons for failure: key already added, passphrase needed but not provided
    print_warning "ssh-add command finished with non-zero status."
    print_warning "This might mean the key was already added, or if you created the key manually with a passphrase, you might need to enter it."
    print_warning "You can check loaded keys with 'ssh-add -l'."
else
    print_success "SSH key added to the agent successfully."
fi


# --- Instruct User to Add Key to GitHub ---
echo "" # Add spacing
if [ -f "$PUB_KEY_PATH" ]; then
    echo -e "\033[1;35m--------------------------------------------------------------------\033[0m"
    echo -e "\033[1;35m✅ ACTION REQUIRED: Add Your Public SSH Key to GitHub\033[0m"
    echo -e "\033[1;35m--------------------------------------------------------------------\033[0m"
    echo "You need to add your *public* SSH key to your GitHub account settings."
    echo ""
    echo -e "\033[1m1. Copy the entire block of text below (your public key):\033[0m"
    echo -e "\033[0;36m" # Cyan color for key
    cat "$PUB_KEY_PATH"
    echo -e "\033[0m" # Reset color
    echo ""
    echo -e "\033[1m2. Go to GitHub in your web browser:\033[0m"
    echo "   https://github.com/settings/keys"
    echo ""
    echo -e "\033[1m3. Click 'New SSH key'.\033[0m"
    echo ""
    echo -e "\033[1m4. Give it a descriptive 'Title' (e.g., 'My New Mac Mini M3').\033[0m"
    echo ""
    echo -e "\033[1m5. Paste the copied public key into the 'Key' field.\033[0m"
    echo ""
    echo -e "\033[1m6. Click 'Add SSH key'.\033[0m"
    echo ""
    echo "After adding the key, you should be able to interact with GitHub repositories using SSH (e.g., git clone git@github.com:...).";
    echo -e "\033[1;35m--------------------------------------------------------------------\033[0m"
else
    # This case should ideally not be reached if key generation/detection worked
    print_error "Could not find the public key file expected at ${PUB_KEY_PATH}."
    print_error "SSH setup for GitHub could not be fully completed."
fi

echo ""
echo "----------------------------------------"
print_success "SSH Key Setup Script Finished."
echo "Remember to add the public key to your GitHub account online if you haven't already!"
echo "----------------------------------------"
exit 0


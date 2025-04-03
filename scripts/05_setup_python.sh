#!/usr/bin/env bash
set -e # Exit immediately if a command exits with a non-zero status.

# -----------------------------------------------------------------------------
# Script: 05_setup_python.sh
# Author: Ravishankar Sivasubramaniam
# Description: Installs Miniconda, initializes it for Zsh, configures channels,
#              and installs packages from ../python/requirements.txt using pip.
#              (Corrected conda environment sourcing for script)
# -----------------------------------------------------------------------------

echo "----------------------------------------"
echo "Starting Python (Miniconda) Setup..."
echo "----------------------------------------"
print_message() { echo "➡️  $1"; }

# --- Determine Directories ---
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
REPO_ROOT_DIR=$(cd "${SCRIPT_DIR}/.." &> /dev/null && pwd) # Assumes scripts are in scripts/ subdir
PYTHON_DIR="${REPO_ROOT_DIR}/python"
REQUIREMENTS_FILE="${PYTHON_DIR}/requirements.txt"

print_message "Repo root directory: ${REPO_ROOT_DIR}"
print_message "Requirements file expected at: ${REQUIREMENTS_FILE}"

# --- Check Prerequisites ---
if ! command -v brew &> /dev/null; then echo "❌ Error: Homebrew not found."; exit 1; fi

# --- Install Miniconda ---
if brew list --cask | grep -q miniconda; then print_message "Miniconda already installed."; else
  print_message "Installing Miniconda via Homebrew Cask..."; brew install --cask miniconda
  print_message "Miniconda installed successfully."
fi

# --- Find Conda Executable ---
print_message "Attempting to find conda executable..."
CONDA_PATH=""
if [[ "$(uname -m)" == "arm64" ]]; then BREW_BIN_PATH="/opt/homebrew/bin/conda"; else BREW_BIN_PATH="/usr/local/bin/conda"; fi

# 1. Check standard Homebrew bin path
if [ -x "$BREW_BIN_PATH" ]; then CONDA_PATH="$BREW_BIN_PATH"; print_message "Found conda via Homebrew bin link: ${CONDA_PATH}"; fi

# 2. If not found, try the Caskroom path
if [ -z "$CONDA_PATH" ]; then
    CASK_CONDA_PATH="$(brew --prefix)/Caskroom/miniconda/latest/base/bin/conda"
    if [ -x "$CASK_CONDA_PATH" ]; then CONDA_PATH="$CASK_CONDA_PATH"; print_message "Found conda via Caskroom path: ${CONDA_PATH}"; fi
fi

# 3. If still not found, maybe it's already in PATH (less likely in clean script)
if [ -z "$CONDA_PATH" ] && command -v conda &>/dev/null; then
    CONDA_PATH=$(command -v conda)
    print_message "Found conda via system PATH: ${CONDA_PATH}"
fi

# Final check for executable
if [ -z "$CONDA_PATH" ] || [ ! -x "$CONDA_PATH" ]; then
    echo "❌ Error: Could not find conda executable after installation."
    # Print checked paths for debugging
    echo "   Checked: ${BREW_BIN_PATH}"
    echo "   Checked: ${CASK_CONDA_PATH:-<Caskroom path not found or checked>}"
    echo "   Checked: System PATH"
    echo "   Please check the Miniconda installation via 'brew info --cask miniconda' or find 'conda' manually."
    exit 1
fi
print_message "Using conda executable at: ${CONDA_PATH}"

# --- Initialize Conda for Zsh ---
print_message "Initializing Conda for Zsh (will modify ~/.zshrc if needed)..."
"$CONDA_PATH" init zsh
print_message "Conda initialized for Zsh."

# --- Source Conda Environment for THIS script session ---
# Use `conda info --base` now that we have a working CONDA_PATH
print_message "Attempting to determine Conda base directory..."
CONDA_BASE=$("$CONDA_PATH" info --base 2>/dev/null) || CONDA_BASE=""

if [ -z "$CONDA_BASE" ]; then
    echo "⚠️ Warning: Could not determine Conda base directory using 'conda info --base'."
    # Fallback: Try deriving from CONDA_PATH if it looks like a bin path
    CONDA_BASE_DERIVED=$(dirname $(dirname "$CONDA_PATH"))
    if [ -f "${CONDA_BASE_DERIVED}/etc/profile.d/conda.sh" ]; then
        CONDA_BASE="$CONDA_BASE_DERIVED"
        print_message "Using derived Conda base: ${CONDA_BASE}"
    else
         echo "⚠️ Warning: Could not derive Conda base directory from executable path either."
    fi
fi

if [ -n "$CONDA_BASE" ] && [ -f "${CONDA_BASE}/etc/profile.d/conda.sh" ]; then
    print_message "Sourcing Conda environment for script session from: ${CONDA_BASE}/etc/profile.d/conda.sh"
    # shellcheck source=/dev/null
    source "${CONDA_BASE}/etc/profile.d/conda.sh"
    # Check if sourcing worked by seeing if `conda activate` is now a function
    if ! command -v conda &>/dev/null || ! type conda | grep -q 'function'; then
         echo "⚠️ Warning: Sourcing conda.sh did not seem to define conda shell functions."
         # Attempting to proceed using full path for activate might still fail
    else
         print_message "Conda environment sourced successfully for script."
    fi
else
    echo "⚠️ Warning: Could not find or source ${CONDA_BASE}/etc/profile.d/conda.sh."
    echo "   'conda activate' and 'pip install' steps might fail."
fi

# --- Configure Conda Channels ---
print_message "Configuring Conda channels..."
"$CONDA_PATH" config --add channels conda-forge || echo "⚠️ Warning: Failed to add conda-forge channel."
"$CONDA_PATH" config --set channel_priority strict || echo "⚠️ Warning: Failed to set channel priority."
print_message "Configured Conda channels (conda-forge, strict priority)."

# --- Install Packages from requirements.txt ---
if [ -f "$REQUIREMENTS_FILE" ]; then
  print_message "Attempting to install packages from ${REQUIREMENTS_FILE} using pip..."
  # Try to activate base environment - this now uses the sourced function if available
  print_message "Activating base environment..."
  conda activate base
  # Check exit code of activate
  if [ $? -ne 0 ]; then
      echo "❌ Error: Failed to activate conda base environment."
      echo "   This usually means the conda shell functions were not sourced correctly."
      echo "   Check warnings above about sourcing 'conda.sh'."
      exit 1
  fi
  print_message "Base environment activated."

  # Find pip within the activated environment
  PIP_PATH=$(which pip) || PIP_PATH="pip" # `which pip` should now find the one in the active env
  print_message "Using pip at: ${PIP_PATH}"

  # Install requirements
  "$PIP_PATH" install -r "$REQUIREMENTS_FILE"
  print_message "Successfully installed packages from ${REQUIREMENTS_FILE}."
  # conda deactivate # Optional: deactivate after install
else
  print_message "Requirements file not found at ${REQUIREMENTS_FILE}. Skipping pip install."
fi

# --- Final Notes ---
echo "----------------------------------------"
echo "Python (Miniconda) Setup Complete."
echo "IMPORTANT: Conda may have modified your ~/.zshrc."
echo "Please RESTART your terminal or run 'source ~/.zshrc' for Conda commands."
echo "Consider creating specific Conda environments for projects."
echo "----------------------------------------"
exit 0

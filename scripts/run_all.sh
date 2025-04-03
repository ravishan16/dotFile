#!/usr/bin/env bash
set -e # Exit immediately if a command exits with a non-zero status.

# -----------------------------------------------------------------------------
# Script: run_all.sh
# Author: Ravishankar Sivasubramaniam
# Description: Master script to run macOS setup scripts. Provides an interactive
7:# Description: Master script to run macOS setup scripts. Provides an interactive
8:#              menu (0-based). Runs selected scripts directly without dependencies.
9:#              Colorized output. Exits on first error.
# -----------------------------------------------------------------------------

# --- Colors ---
C_RESET='\033[0m'; C_RED='\033[0;31m'; C_GREEN='\033[0;32m'; C_YELLOW='\033[0;33m'; C_BLUE='\033[0;34m'; C_MAGENTA='\033[0;35m'; C_CYAN='\033[0;36m'; C_BOLD='\033[1m'; C_DIM='\033[2m'

# --- Determine Directories ---
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
REPO_ROOT_DIR=$(cd "${SCRIPT_DIR}/.." &> /dev/null && pwd) # Assumes scripts are in scripts/ subdir
ENV_FILE="${REPO_ROOT_DIR}/.env"

# --- Available Scripts (Order Matters!) ---
AVAILABLE_SCRIPTS=(
  "00_install_homebrew.sh"    # Index 0
  "01_setup_folders.sh"       # Index 1
  "02_install_brew_core.sh"   # Index 2
  "03_setup_git.sh"           # Index 3
  "04_setup_zsh.sh"           # Index 4
  "05_setup_python.sh"        # Index 5
  "06_install_apps_cask.sh"   # Index 6
  "07_configure_macos.sh"     # Index 7
  "08_setup_ssh_github.sh"    # Index 8
)
NUM_SCRIPTS="${#AVAILABLE_SCRIPTS[@]}"
LAST_INDEX=$((NUM_SCRIPTS - 1)) # Last valid index (0-based)

# --- Helper Functions ---
print_message() { echo -e "${C_BLUE}➡️  $1${C_RESET}"; }

display_menu() {
    echo -e "${C_BOLD}${C_MAGENTA}----------------------------------------${C_RESET}"
    echo -e "${C_BOLD}${C_MAGENTA}macOS Setup Script Runner${C_RESET}"
    echo -e "${C_BOLD}${C_MAGENTA}----------------------------------------${C_RESET}"
    echo -e "${C_CYAN}Available Scripts:${C_RESET}"
    local i=0; for script_name in "${AVAILABLE_SCRIPTS[@]}"; do printf "%2d) %s\n" "$i" "$script_name"; i=$((i + 1)); done; echo ""
    echo -e "${C_CYAN}Options:${C_RESET}"
    echo -e "  ${C_BOLD}all${C_RESET}) Run all scripts (0-${LAST_INDEX}) in sequence"
    echo -e "   ${C_BOLD}#${C_RESET}) Run ONLY specific script number(s) (e.g., '0 2 4')" # Clarified
    echo -e "   ${C_BOLD}q${C_RESET}) Quit"
    echo -e "${C_BOLD}${C_MAGENTA}----------------------------------------${C_RESET}"
}

run_script() {
  local script_name="$1"; local script_path="${SCRIPT_DIR}/${script_name}"
  if [ ! -f "$script_path" ]; then echo -e "${C_RED}❌ Error: Script not found: ${script_path}${C_RESET}"; return 1; fi
  echo ""; echo -e "${C_BOLD}${C_CYAN}--- Executing: ${script_name} ---${C_RESET}"
  chmod +x "$script_path"
  # Run the script. set -e will cause exit if it fails.
  bash "$script_path"
  echo -e "${C_GREEN}${C_BOLD}--- ✅ Completed: ${script_name} ---${C_RESET}"
  return 0 # Return success if set -e didn't exit
}

# --- Main Execution Logic ---
echo -e "${C_DIM}Running scripts from: ${SCRIPT_DIR}${C_RESET}"
if [ ! -f "$ENV_FILE" ]; then echo -e "${C_YELLOW}⚠️ Warning: '.env' not found at ${ENV_FILE}.${C_RESET}"; read -p "Press Enter to continue or Ctrl+C..."; else print_message ".env file found."; fi

while true; do
    display_menu
    read -p "$(echo -e ${C_BOLD}${C_YELLOW}"Enter choice(s) (e.g., 0 2 4, all, q): "${C_RESET})" user_choice
    user_choice=$(echo "$user_choice" | xargs)

    case "$user_choice" in
        q|Q|"") echo -e "${C_BLUE}Exiting setup.${C_RESET}"; break ;; # Quit
        all|ALL) # Run all scripts
            echo -e "${C_BLUE}Running all setup scripts...${C_RESET}"
            script_index=0
            for script in "${AVAILABLE_SCRIPTS[@]}"; do
                run_script "$script" # set -e will handle exit on failure
                script_index=$((script_index + 1))
            done
            echo -e "${C_GREEN}${C_BOLD}🎉 All scripts completed successfully!${C_RESET}"
            break # Exit after running 'all'
            ;;
        *) # Handle number(s) input - Run ONLY selected scripts
            selected_indices=()
            valid_input=true
            for choice in $user_choice; do # Validate input
                if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 0 ] && [ "$choice" -le "$LAST_INDEX" ]; then
                    selected_indices+=("$choice") # Input is the 0-based index
                else echo -e "${C_RED}❌ Invalid input: '$choice'. Enter numbers between 0-${LAST_INDEX}, 'all', or 'q'.${C_RESET}"; valid_input=false; break; fi
            done

            if $valid_input; then
                echo -e "${C_BLUE}Running ONLY selected scripts...${C_RESET}"
                echo -e "${C_YELLOW}⚠️ Warning: Dependencies are NOT automatically run. Ensure prerequisites are met.${C_RESET}"
                echo "--- Execution Plan ---"
                for index in "${selected_indices[@]}"; do
                    printf "  %2d) %s\n" "$index" "${AVAILABLE_SCRIPTS[$index]}"
                done
                echo "----------------------"
                read -p "$(echo -e ${C_YELLOW}${C_BOLD}"Run ONLY these scripts? (y/N): "${C_RESET})" confirm_run_selected

                if [[ "$confirm_run_selected" =~ ^[Yy]$ ]]; then
                    for index in "${selected_indices[@]}"; do
                        script_name="${AVAILABLE_SCRIPTS[$index]}"
                        run_script "$script_name" # set -e will handle exit on failure
                    done
                    echo -e "${C_GREEN}${C_BOLD}✅ Selected scripts completed.${C_RESET}"
                else
                    echo -e "${C_BLUE}Aborted execution.${C_RESET}"
                fi
            fi
            # Loop back to menu
            echo ""; read -p "$(echo -e ${C_DIM}"Press Enter to return to the menu..."${C_RESET})"
            ;;
    esac
done

# --- Final Reminders ---
echo ""; echo -e "${C_MAGENTA}${C_BOLD}--- Setup Finished ---${C_RESET}";
echo -e "${C_YELLOW}${C_BOLD}REMEMBER POST-SETUP STEPS:${C_RESET}"; echo "1. Restart terminal/log out & log in."
echo "2. Add SSH key to GitHub (if script 08 ran)."; echo "3. Log into GUI apps."
echo "4. Further tool configurations."; echo -e "${C_MAGENTA}${C_BOLD}----------------------${C_RESET}"

exit 0

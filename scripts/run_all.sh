#!/usr/bin/env bash
set -e # Keep commented out for interactive menu logic
# set -e # Keep commented out for interactive menu logic

# -----------------------------------------------------------------------------
# Script: run_all.sh
# Author: Ravishankar Sivasubramaniam
# Description: Master script to run macOS setup scripts. Provides an interactive
#              menu. Includes dependencies by default, offers force run option.
#              Colorized output.
# -----------------------------------------------------------------------------

# --- Colors ---
C_RESET='\033[0m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[0;33m'
C_BLUE='\033[0;34m'
C_MAGENTA='\033[0;35m'
C_CYAN='\033[0;36m'
C_BOLD='\033[1m'
C_DIM='\033[2m'

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
  "09_setup_ssh_github.sh"    # Index 8
)

# --- Script Dependencies (Index -> Prerequisite Indices) ---
declare -A SCRIPT_DEPS
SCRIPT_DEPS[0]=""      # 00: No dependencies
SCRIPT_DEPS[1]=""      # 01: No hard script dependencies (reads .env)
SCRIPT_DEPS[2]="0"     # 02: Depends on 00 (Homebrew)
SCRIPT_DEPS[3]="2"     # 03: Depends on 02 (Git) -> indirectly 00
SCRIPT_DEPS[4]="0 2"   # 04: Depends on 00 (Homebrew), 02 (Zsh, Git)
SCRIPT_DEPS[5]="0"     # 05: Depends on 00 (Homebrew)
SCRIPT_DEPS[6]="0"     # 06: Depends on 00 (Homebrew)
SCRIPT_DEPS[7]="2"     # 07: Depends on 02 (dockutil) -> indirectly 00
SCRIPT_DEPS[8]="0 3"   # 09: Depends on 00 (Xcode tools check), 03 (Git config/env) -> indirectly 02

# --- Helper Functions ---
print_message() { echo -e "${C_BLUE}➡️  $1${C_RESET}"; } # Blue for general messages

display_menu() {
    echo -e "${C_BOLD}${C_MAGENTA}----------------------------------------${C_RESET}"
    echo -e "${C_BOLD}${C_MAGENTA}macOS Setup Script Runner${C_RESET}"
    echo -e "${C_BOLD}${C_MAGENTA}----------------------------------------${C_RESET}"
    echo -e "${C_CYAN}Available Scripts:${C_RESET}"
    local i=1
    for script_name in "${AVAILABLE_SCRIPTS[@]}"; do
        # Use dim for script name? Or keep plain? Let's keep plain.
        printf "%2d) %s\n" "$i" "$script_name"
        i=$((i + 1))
    done
    echo ""
    echo -e "${C_CYAN}Options:${C_RESET}"
    echo -e "  ${C_BOLD}all${C_RESET}) Run all scripts (0-9) in sequence"
    echo -e "   ${C_BOLD}#${C_RESET}) Run specific script number(s) (e.g., '1 3 5')"
    echo -e "   ${C_BOLD}q${C_RESET}) Quit"
    echo -e "${C_BOLD}${C_MAGENTA}----------------------------------------${C_RESET}"
}

run_script() {
  local script_name="$1"; local script_path="${SCRIPT_DIR}/${script_name}"
  if [ ! -f "$script_path" ]; then echo -e "${C_RED}❌ Error: Script not found: ${script_path}${C_RESET}"; return 1; fi
  # Use Cyan Bold for execution header
  echo ""; echo -e "${C_BOLD}${C_CYAN}--- Executing: ${script_name} ---${C_RESET}"
  chmod +x "$script_path"
  # Run script, capture output/errors if needed, check exit code
  if bash "$script_path"; then
      echo -e "${C_GREEN}${C_BOLD}--- ✅ Completed: ${script_name} ---${C_RESET}"
      return 0 # Success
  else
      local exit_code=$?
      echo -e "${C_RED}${C_BOLD}--- ❌ Error: ${script_name} failed with exit code ${exit_code}. ---${C_RESET}"
      return $exit_code # Propagate error code
  fi
}

declare -A visited_deps # Keep track of visited nodes during recursion for one selection set
get_all_deps() {
    local current_index=$1; local deps_string="${SCRIPT_DEPS[$current_index]}"; local all_req_indices=()
    visited_deps["$current_index"]=1 # Mark current index as visited
    for dep_index in $deps_string; do # Add direct dependencies
        if [[ -z "${visited_deps[$dep_index]}" ]]; then # If not visited in this branch
             all_req_indices+=("$dep_index") # Add the dependency
             nested_deps=$(get_all_deps "$dep_index"); all_req_indices+=($nested_deps) # Recurse
        fi
    done; echo "${all_req_indices[@]}" | tr ' ' '\n' | sort -un | tr '\n' ' ' # Return unique deps
}

# --- Main Execution Logic ---
echo -e "${C_DIM}Running scripts from: ${SCRIPT_DIR}${C_RESET}"
if [ ! -f "$ENV_FILE" ]; then echo -e "${C_YELLOW}⚠️ Warning: '.env' not found at ${ENV_FILE}.${C_RESET}"; read -p "Press Enter to continue or Ctrl+C..."; else print_message ".env file found."; fi

while true; do
    display_menu
    # Yellow Bold for prompt
    read -p "$(echo -e ${C_BOLD}${C_YELLOW}"Enter choice(s) (e.g., 1 3 5, all, q): "${C_RESET})" user_choice
    user_choice=$(echo "$user_choice" | xargs)

    case "$user_choice" in
        q|Q|"") echo -e "${C_BLUE}Exiting setup.${C_RESET}"; break ;; # Quit
        all|ALL) # Run all scripts
            echo -e "${C_BLUE}Running all setup scripts...${C_RESET}"
            all_success=true; script_index=0
            for script in "${AVAILABLE_SCRIPTS[@]}"; do
                if ! run_script "$script"; then
                    all_success=false
                    read -p "$(echo -e ${C_YELLOW}"Script $((script_index + 1)) ('$script') failed. Continue? (y/N): "${C_RESET})" continue_on_fail
                    if [[ ! "$continue_on_fail" =~ ^[Yy]$ ]]; then echo -e "${C_RED}Aborting.${C_RESET}"; break; fi
                fi; script_index=$((script_index + 1))
            done
            if $all_success; then echo -e "${C_GREEN}${C_BOLD}🎉 All scripts completed!${C_RESET}"; else echo -e "${C_YELLOW}⚠️ Some scripts failed.${C_RESET}"; fi
            break # Exit after running 'all'
            ;;
        *) # Handle number(s) input with dependency check AND force option
            initial_selection_indices=()
            valid_input=true
            for choice in $user_choice; do # Validate input
                if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#AVAILABLE_SCRIPTS[@]}" ]; then
                    initial_selection_indices+=($((choice - 1)))
                else echo -e "${C_RED}❌ Invalid input: '$choice'.${C_RESET}"; valid_input=false; break; fi
            done

            if $valid_input; then
                # Calculate dependencies
                all_required_indices=("${initial_selection_indices[@]}")
                for index in "${initial_selection_indices[@]}"; do visited_deps=(); deps=$(get_all_deps "$index"); all_required_indices+=($deps); done
                IFS=' ' read -r -a sorted_unique_indices <<< "$(echo "${all_required_indices[@]}" | tr ' ' '\n' | sort -un)"

                # Display plan
                echo ""; echo -e "${C_MAGENTA}${C_BOLD}----------------------------------------${C_RESET}"; echo -e "${C_BOLD}Execution Plan (including dependencies):${C_RESET}"; echo -e "${C_MAGENTA}${C_BOLD}----------------------------------------${C_RESET}"
                for index in "${sorted_unique_indices[@]}"; do printf "  - %s\n" "${AVAILABLE_SCRIPTS[$index]}"; done
                echo -e "${C_MAGENTA}${C_BOLD}----------------------------------------${C_RESET}"
                read -p "$(echo -e ${C_YELLOW}${C_BOLD}"Run these scripts in the listed order? (y/N): "${C_RESET})" confirm_plan

                if [[ "$confirm_plan" =~ ^[Yy]$ ]]; then
                    # --- Execute the full plan (dependencies + selection) ---
                    echo -e "${C_BLUE}Running selected scripts + dependencies...${C_RESET}"
                    any_failed=false
                    for index in "${sorted_unique_indices[@]}"; do
                        script_name="${AVAILABLE_SCRIPTS[$index]}"
                        if ! run_script "$script_name"; then any_failed=true; echo -e "${C_RED}Aborting remaining scripts due to failure.${C_RESET}"; break; fi
                    done
                    if $any_failed; then echo -e "${C_YELLOW}⚠️ Execution stopped due to script failure.${C_RESET}"; else echo -e "${C_GREEN}${C_BOLD}✅ All planned scripts completed successfully.${C_RESET}"; fi
                else
                    # --- Offer to force run ONLY if exactly ONE script was initially selected ---
                    if [ "${#initial_selection_indices[@]}" -eq 1 ]; then
                        # FIX: Remove 'local' keyword here
                        initial_index="${initial_selection_indices[0]}"
                        initial_script_name="${AVAILABLE_SCRIPTS[$initial_index]}"
                        # Use printf for prompt formatting consistency
                        printf "${C_YELLOW}${C_BOLD}Run ONLY script %d ('%s') without dependencies? Use with caution! (y/N): ${C_RESET}" "$((initial_index + 1))" "$initial_script_name"
                        read confirm_force
                        if [[ "$confirm_force" =~ ^[Yy]$ ]]; then
                            echo -e "${C_YELLOW}${C_BOLD}FORCE RUNNING: ${initial_script_name}${C_RESET}"
                            run_script "$initial_script_name" # Run only the selected one
                        else
                            echo -e "${C_BLUE}Aborted execution.${C_RESET}"
                        fi
                    else
                         echo -e "${C_BLUE}Aborted execution. Force run option only available when selecting a single script.${C_RESET}"
                    fi
                fi
            fi
            # Loop back to menu
            echo ""; read -p "$(echo -e ${C_DIM}"Press Enter to return to the menu..."${C_RESET})"
            ;;
    esac
done

# --- Final Reminders ---
echo ""; echo -e "${C_MAGENTA}${C_BOLD}----------------------------------------${C_RESET}"; echo -e "${C_BOLD}Setup script finished.${C_RESET}"; echo -e "${C_MAGENTA}${C_BOLD}----------------------------------------${C_RESET}"
echo -e "${C_YELLOW}${C_BOLD}REMEMBER POST-SETUP STEPS (if applicable):${C_RESET}"; echo "1. Restart terminal/log out & log in."
echo "2. Add SSH key to GitHub (if script 09 ran)."; echo "3. Log into GUI apps."
echo "4. Further tool configurations (VS Code extensions, etc.)."; echo -e "${C_MAGENTA}${C_BOLD}----------------------------------------${C_RESET}"

exit 0

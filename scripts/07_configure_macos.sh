#!/usr/bin/env bash
set -e # Exit immediately if a command exits with a non-zero status.

# -----------------------------------------------------------------------------
# Script: 07_configure_macos.sh
# Author: Ravishankar Sivasubramaniam
# Description: Configures a simplified set of reliable macOS settings and Dock.
#              Includes detailed comments on applied and omitted settings.
# -----------------------------------------------------------------------------

echo "----------------------------------------"
echo "Starting macOS Configuration (Simplified)..."
echo "----------------------------------------"
print_message() { echo "➡️  $1"; }

# Request sudo upfront for potential system-level changes
print_message "Requesting administrator privileges..."
sudo -v
# Keep sudo session alive while script runs
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
print_message "Sudo credentials obtained."

# Close System Settings/Preferences to avoid conflicts
print_message "Closing System Settings/Preferences..."
osascript -e 'tell application "System Settings" to quit' &> /dev/null
osascript -e 'tell application "System Preferences" to quit' &> /dev/null

# --- Generally Reliable macOS Settings ---
# Applying a curated list of settings known to be relatively stable via `defaults write`.
print_message "Applying simplified macOS settings..."

# Hide Keyboard Brightness controls from Menu Bar and Control Center
# Domain: com.apple.controlcenter, Key: KeyboardBrightness, Value: 18 (Do Not Show)
defaults write com.apple.controlcenter "NSStatusItem Visible KeyboardBrightness" -bool false; defaults write com.apple.controlcenter KeyboardBrightness -int 18; print_message "Keyboard Brightness hidden from Control Center/Menu Bar."

# Ensure Siri icon is visible in the Menu Bar
# Domain: com.apple.Siri, Key: StatusMenuVisible
defaults write com.apple.Siri StatusMenuVisible -bool true; print_message "Siri Menu Bar icon shown."

# Ensure Time Machine icon is visible in the Menu Bar
# Domain: com.apple.TimeMachine, Key: ShowMenuExtra
defaults write com.apple.TimeMachine ShowMenuExtra -bool true; print_message "Time Machine Menu Bar icon shown."

# Configure Menu Bar auto-hide behavior: Only hide in Full Screen mode
# Domain: NSGlobalDomain (system-wide), Keys: AppleMenuBarVisibleInFullscreen, _HIHideMenuBar
defaults write NSGlobalDomain AppleMenuBarVisibleInFullscreen -bool true; defaults write NSGlobalDomain _HIHideMenuBar -bool false; print_message "Menu Bar auto-hide set to 'In Full Screen Only'."

# Set the number of recent items (Apps, Documents, Servers) shown in Apple Menu -> Recent Items
# Domain: NSGlobalDomain (system-wide), Key: NSRecentDocumentsLimit
defaults write NSGlobalDomain NSRecentDocumentsLimit -int 10; print_message "Recent items limit set to 10."

# Show battery percentage in the Menu Bar (if the battery menu extra is enabled)
# Domain: com.apple.menuextra.battery, Key: ShowPercent
defaults write com.apple.menuextra.battery ShowPercent -string "YES"; print_message "Battery Percentage shown in Menu Bar."

# --- Omitted Settings ---
# The following settings, potentially discussed or visible in screenshots,
# were intentionally OMITTED from this simplified script due to reliability concerns
# or complexity in scripting them accurately across different macOS versions:
#   - Wi-Fi Menu Bar visibility (often managed by system automatically or fragile menuExtras)
#   - Bluetooth Menu Bar visibility (similar to Wi-Fi)
#   - AirDrop Menu Bar visibility (not a standard menu bar item)
#   - Focus Mode Menu Bar visibility ('Show When Active' is hard to script reliably)
#   - Stage Manager Menu Bar visibility (newer feature, defaults keys might change)
#   - Screen Mirroring Menu Bar visibility (defaults key behavior can vary)
#   - Sound Menu Bar visibility (often managed by system or fragile menuExtras)
#   - Now Playing Menu Bar visibility ('Show When Active' is hard to script reliably)
#   - Accessibility Shortcuts visibility in Control Center/Menu Bar
#   - Battery visibility *in Control Center* (distinct from Menu Bar percentage)
# You can try adding these back by finding reliable `defaults write` commands or
# exploring your original comprehensive `macos.sh` file, but be aware they might
# not work as expected or could break in future macOS updates.

# --- Dock Cleanup & Configuration ---
print_message "Configuring the Dock..."
# Check if dockutil command is available
if ! command -v dockutil &> /dev/null; then echo "❌ Error: dockutil not found. Install via script 02."; exit 1; fi

print_message "Using dockutil to configure Dock items."
# Remove all persistent app icons (keeps Finder/Trash)
# Use || true to prevent script exit if dockutil fails (e.g., Dock is already empty)
dockutil --remove all --no-restart || echo "⚠️ Warning: 'dockutil --remove all' failed (maybe Dock was empty?)."
print_message "Removed existing persistent app icons from Dock."

# Define the desired applications for the Dock
DOCK_APPS=(
    "/System/Applications/System Settings.app"        # System Settings (or Preferences)
    "/Applications/Brave Browser.app"                 # User installed browser
    "/Applications/Google Chrome.app"                 # User installed browser
    "/Applications/Visual Studio Code.app"            # Code editor
    "/Applications/iTerm.app"                         # Terminal
    "/Applications/Warp.app"                          # Terminal
    "/Applications/Discord.app"                       # Communication

    # Add full paths to other desired apps here
)

# Add defined applications to the Dock
for app_path in "${DOCK_APPS[@]}"; do
    if [ -d "$app_path" ]; then # Check if the application actually exists
        print_message "Adding $(basename "$app_path" .app) to Dock..."
        # Use || true to prevent script exit if adding a single item fails
        dockutil --add "$app_path" --no-restart || echo "⚠️ Warning: Failed to add ${app_path} to Dock."
    else
        echo "⚠️ Warning: Application not found at ${app_path}. Skipping."
    fi
done

# Add the Downloads folder as a stack, sorted by date added, displayed as a folder icon
print_message "Adding Downloads stack to Dock..."
dockutil --add '~/Downloads' --view grid --display folder --sort dateadded --no-restart || echo "⚠️ Warning: Failed to add Downloads stack to Dock."

# Restart the Dock process to apply changes
print_message "Dock configuration complete. Restarting Dock...";
killall Dock

# --- Kill Affected Applications ---
# Restart relevant system services to help apply settings without a full logout
print_message "Applying settings by restarting affected applications/services..."
for app in "cfprefsd" "Dock" "Finder" "SystemUIServer" "Siri" "TimeMachine"; do
    # Use killall command, redirect output, and use `|| true` to prevent script exit if app not running
    killall "${app}" > /dev/null 2>&1 || true
done
print_message "Finished restarting services."

echo "----------------------------------------"
echo "macOS Configuration Complete (Simplified)."
echo "Note: Some changes may still require a logout/restart to take full effect."
echo "----------------------------------------"
exit 0

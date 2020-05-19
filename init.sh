#!/usr/bin/env bash

#install Home Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

#instal Brew and Cask packages
set -- -f; source brew/install-brew.sh
set -- -f; source brew/install-cask.sh


#Set Macos Default
source system/macos.sh

# Clean Dock
dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --no-restart --add "/Applications/Microsoft Outlook.app"
dockutil --no-restart --add "/Applications/Slack.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/"
dockutil --no-restart --add "~/Downloads/"

killall Dock
#!/usr/bin/env bash

#install Home Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

#instal Brew and Cask packages
set -- -f; source brew/install-brew.sh
set -- -f; source brew/install-cask.sh

#Install Python ( Minocnda in Brew Cask)
conda init "$(basename "${SHELL}")"
#set conda forge channel
conda config --add channels conda-forge
conda config --set channel_priority strict
pip install -r python/requirements.txt

# Clean Dock
dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Google Chrome.app"
# dockutil --no-restart --add "/Applications/Microsoft Outlook.app"
dockutil --no-restart --add "/Applications/Slack.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/"
dockutil --no-restart --add "~/Downloads/"

killall Dock

#Set Macos Default
source system/macos.sh
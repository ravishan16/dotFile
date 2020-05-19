#!/usr/bin/env bash

#install Home Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

#instal Brew and Cask packages
set -- -f; source brew/install-brew.sh
set -- -f; source brew/install-cask.sh


#Set Macos Default
source system/macos.sh
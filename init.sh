#!/usr/bin/env bash

SOURCE="https://github.com/ravishan16/dotFile"
TARBALL="$SOURCE/tarball/master"
TARGET="$HOME/.dotfiles"

mkdir -p "$TARGET"

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew tap caskroom/versions
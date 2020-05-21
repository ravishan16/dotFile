# dotFile

Ravi's Dotfile Mac setup from scratch
This is WIP!!!!!

# References
- [Mathias Bynens Dotfiles](https://github.com/mathiasbynens/dotfiles)!
- [Oh My Zsh](https://ohmyz.sh/)!
- [Zach Holman Dotfiles](https://github.com/holman/dotfiles)!
- [Getting Started With Dotfiles - Lars Kappert](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789)!
- [Awesome Dotfiles](https://project-awesome.org/webpro/awesome-dotfiles)!

## Install Command Line Tools

```shell
sudo softwareupdate -i -a
xcode-select --install
```

## Create Project Directories

```shell
mkdir -p ~/projects/git
cd ~/projects/git
```

## Git Clone

```
git clone https://github.com/ravishan16/dotfile/
cd dotfile
```

## Install Brew Packages

```
source init.sh
```

## Instal OhMyZsh

```
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

### Plugin

git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

```

### Replace ~/.zshrc

```
mv ~/.zshrc ~/.zshrc.backup
cp ~/projects/git/dotfile/dot/.zshrc ~/.zshrc
```


### Install Python (Miniconda)
```
brew cask install python
 conda init "$(basename "${SHELL}")"

```

### Dock Cleanup
```
dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Google Chrome.app"
# dockutil --no-restart --add "/Applications/Microsoft Outlook.app"
dockutil --no-restart --add "/Applications/Slack.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/"
dockutil --no-restart --add "~/Downloads/"

killall Dock
```

### HomeBrew Packages
```
brew install coreutils
brew install mas
brew install moreutils
brew install findutils
brew install gnu-sed

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim 
brew install grep
brew install openssh
brew install screen
brew install gmp

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install other useful binaries.
brew install ack
brew install git
brew install git-lfs
brew install ssh-copy-id
brew install asciinema
brew install supervisor
brew install tree
brew install node
brew install wget 
brew install htop
brew install hugo
brew install zsh
brew install zsh-syntax-highlighting
brew install autojump
brew install zsh-autosuggestions
brew install utf8proc
brew install dockutil
brew install rename
brew install imagemagick 

# Cloud
brew cask install osxfuse
brew install gcsfuse
brew install awscli

# Remove outdated versions from the cellar.
brew upgrade
brew cleanup

```

### Brew Casks
```
#brew cask
brew cask install dropbox
brew cask install google-chrome
brew cask install firefox
brew cask install spotify
brew cask install alfred
brew cask install cheatsheet
brew cask install keycastr
brew cask install itsycal
brew cask install grammarly
brew cask install ccleaner
brew cask install keybase
#Dev Tools
brew cask install ngrok
brew cask install iterm2
brew cask install osxfuse
brew cask install dbeaver-community
brew cask install gitkraken
brew cask install visual-studio-code
# brew cask install docker
brew cask install miniconda

#Communication
brew cask install skype
brew cask install zoomus
brew cask install blue-jeans
brew cask install slack
brew cask install microsoft-teams

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode
brew cask install qlimagesize
brew cask install qlmarkdown
brew cask install qlstephen
brew cask install qlvideo
brew cask install quicklook-json
brew cask install quicklook-csv
brew cask install suspicious-package
brew cask install webpquicklook
brew cask install betterzip
```

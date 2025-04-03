# ~/.zshrc
# vim: ft=zsh

# ------------------------------------------------------------------------------
# Zsh Configuration - Managed by Dotfiles
# ------------------------------------------------------------------------------

# Enable Powerlevel10k instant prompt. Should stay close to the top.
# Initialization code that may require console input must go above this block.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------------------------------------------------------
# Environment Variables & Paths
# ------------------------------------------------------------------------------

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Add Homebrew to PATH and configure environment
# Ensure this path matches your Homebrew installation (usually /opt/homebrew for Apple Silicon)
if [ -x "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
 eval "$(/usr/local/bin/brew shellenv)"
fi

# Add coreutils gnubin to PATH for GNU versions without 'g' prefix
if [ -d "/opt/homebrew/opt/coreutils/libexec/gnubin" ]; then # Apple Silicon
    export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
elif [ -d "/usr/local/opt/coreutils/libexec/gnubin" ]; then # Intel
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi

# Add user's local bin directory (if it exists)
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# Add other custom paths here if needed
# export PATH="/your/custom/path:$PATH"

# Set default editor (optional)
# export EDITOR='vim'

# Set language environment (optional)
# export LANG=en_US.UTF-8

# ------------------------------------------------------------------------------
# Oh My Zsh Configuration
# ------------------------------------------------------------------------------

# Oh My Zsh Theme
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Oh My Zsh Plugins
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
# Add wisely, as too many plugins slow down shell startup.
# git: standard git aliases and functions
# zsh-autosuggestions: Fish-like autosuggestions based on history
# zsh-syntax-highlighting: Command syntax highlighting
# autojump: Faster directory navigation (remembers frequently used dirs)
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  autojump
  # Add other plugins here, e.g., docker, python, node, etc.
)

# Oh My Zsh Update Settings (optional)
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' frequency 7    # update every week

# Source Oh My Zsh main script
# IMPORTANT: This should generally be loaded AFTER setting ZSH_THEME, plugins, etc.
source "$ZSH/oh-my-zsh.sh"

# ------------------------------------------------------------------------------
# Custom Aliases and Functions
# ------------------------------------------------------------------------------
# These files are symlinked from your dotfiles repo (dot/ directory) by script 04

# Source custom aliases if file exists
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

# Source custom functions if file exists
[ -f "$HOME/.functions" ] && source "$HOME/.functions"

# ------------------------------------------------------------------------------
# Tool Specific Configurations & Completions
# ------------------------------------------------------------------------------

# Conda Initialization (Managed by 'conda init')
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# Docker Desktop CLI completions (Added by Docker Desktop)
if [ -f "$HOME/.docker/completions/zsh/_docker" ]; then
    fpath=($HOME/.docker/completions $fpath)
    # autoload -Uz compinit && compinit # Compinit might be run by Oh My Zsh already
fi
# End of Docker CLI completions


# Ngrok completions (Suggested by brew install ngrok)
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

# Autojump initialization (if using autojump without the Oh My Zsh plugin)
# The Oh My Zsh plugin should handle this if 'autojump' is in the plugins array.
# If not using the plugin, uncomment the relevant line below:
# [ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh # Apple Silicon
# [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh # Intel

# Git LFS Initialization (Run once manually)
# Homebrew suggests running this after installing git-lfs. You only need to do it once.
# git lfs install --system

# ------------------------------------------------------------------------------
# Powerlevel10k Theme Initialization
# ------------------------------------------------------------------------------
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# This file is symlinked from your dotfiles repo (dot/ directory) by script 04
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#00ffff"


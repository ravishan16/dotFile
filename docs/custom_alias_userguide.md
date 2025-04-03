# User Guide: Custom Shell Aliases & Functions 🛠️

Make your terminal work *for you*! Zsh allows you to create **aliases** (short nicknames for long commands) and **functions** (mini-scripts for complex tasks). This saves typing and makes repetitive actions much faster.

Your setup organizes these customizations in files within your `dot/` repository folder, which are then linked to your home directory (`~`) and loaded automatically by Zsh.

## What are "Dotfiles" Again?

They are configuration files usually starting with a `.` (like `.zshrc`, `.gitconfig`). Your setup keeps yours neatly in the `dot/` folder of your `dotFile` repository (e.g., `~/Projects/git/dotFile/dot/`). This is great because you can track changes to your configuration using Git!

## Aliases: Your Command Nicknames (`dot/.aliases`)

An alias is just a shortcut. Instead of typing a long command repeatedly, you type its short alias.

* **Why use them?** Save keystrokes, remember complex options easily.
* **Where to define them?** In your `dot/.aliases` file. *(Make sure your main `dot/.zshrc` file actually loads this! It might have a line like `source ~/.aliases` or `[ -f ~/.aliases ] && source ~/.aliases`)*.
* **Syntax:** `alias nickname="your_long_command --with --options"`
    * No spaces around the `=`.
    * Use double quotes (`"`) around the command.
* **Examples (Add these to `dot/.aliases`):**
    ```bash
    # --- Navigation ---
    alias ..="cd .."
    alias ...="cd ../.."
    alias ....="cd ../../.."
    alias home="cd ~"
    alias proj="cd ~/Projects/git" # Adjust to your GIT_HOME!

    # --- Listing Files (using enhanced ls/gls if available) ---
    # Basic ls with colors (macOS default)
    # alias ls='ls -G'
    # OR, if you installed 'coreutils' with Homebrew (provides 'gls'):
    alias ls='gls --color=auto -F' # Use GNU ls with colors and type indicators (/)
    alias ll='ls -al'              # Long format, all files, human sizes from ls alias
    alias la='ls -A'               # List all except . and ..

    # --- Git --- (Oh My Zsh git plugin adds many, but here are more)
    alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    alias gaa='git add --all'
    alias gb='git branch'
    alias gba='git branch -a'
    alias gd='git diff'
    alias gds='git diff --staged'

    # --- System ---
    alias update='echo "Updating macOS..."; sudo softwareupdate -i -a; echo "Updating Homebrew..."; brew update && brew upgrade; echo "Cleaning up Brew..."; brew cleanup; echo "Checking Brew Doctor..."; brew doctor' # Multi-step update
    alias cl='clear'
    alias ip='ipconfig getifaddr en0 || ipconfig getifaddr en1' # Show local IP
    alias ports='sudo lsof -i -P | grep LISTEN' # Show open network ports

    # --- Docker ---
    alias dps='docker ps'
    alias dpsa='docker ps -a'
    alias di='docker images'
    alias dprune='docker system prune -af' # Prune all Docker stuff forcefully (Careful!)
    ```
* **How to Use:** Just type the alias (e.g., `ll`, `proj`, `update`) and press Enter.
* **See All Aliases:** Type `alias` in the terminal.
* **Activate Changes:** After editing `dot/.aliases`, **close and reopen your terminal tab/window** OR run `source ~/.aliases` in your current session.

## Functions: Your Mini-Scripts (`dot/.functions`)

Functions are more powerful than aliases. They can take inputs (arguments), run multiple commands, use logic (like `if`/`else`), and create temporary variables.

* **Why use them?** Automate multi-step tasks, create smarter custom commands.
* **Where to define them?** In your `dot/.functions` file. *(Again, make sure `dot/.zshrc` loads it, e.g., `source ~/.functions`)*.
* **Syntax:**
    ```bash
    # Preferred multi-line format
    function_name() {
      echo "Starting function..."
      # Use $1 for the first argument, $2 for second, etc.
      # Use $@ to refer to all arguments
      ls -l "$1" # Example: list details of the first argument
      echo "Finished."
      # return 0 # Optional: Indicate success
    }

    # Short one-liner format
    short_func() { command1 && command2; }
    ```
* **Examples (Add these to `dot/.functions`):**
    ```bash
    # Create a directory and cd into it
    mcd() {
      mkdir -p "$1" && cd "$1" || return 1 # Added error check
      echo "Created and entered directory: $1"
    }

    # Backup a file with timestamp
    bak() {
      local timestamp=$(date +%Y%m%d_%H%M%S)
      cp "$1" "$1.${timestamp}.bak" && echo "Backed up '$1' to '$1.${timestamp}.bak'"
    }

    # Search command history easily
    hgrep() {
      history | grep "$@"
    }

    # Start a simple Python HTTP server in the current directory
    serve() {
      local port="${1:-8000}" # Use port 8000 by default, or first argument if given
      echo "Serving current directory on http://localhost:${port}"
      python -m http.server "$port"
    }

    # Git add, commit, push (use with care!)
    gacp() {
      if [ -z "$1" ]; then
        echo "❌ Error: Commit message is required."
        echo "Usage: gacp \"Your commit message\""
        return 1 # Indicate error
      fi
      git add . && git commit -m "$1" && git push
    }
    ```
* **How to Use:** Type the function name, optionally followed by arguments, then press Enter.
    * `mcd my_cool_project`
    * `bak important_notes.txt`
    * `hgrep brew install` (searches history for lines containing "brew install")
    * `serve 9090` (starts server on port 9090)
    * `gacp "Implement user login"`
* **Activate Changes:** Same as aliases - **restart the terminal** or run `source ~/.functions`.

Customize these files to match your workflow! Keep them organized and add comments (`#`) to explain what your aliases and functions do. Don't forget to `git add`, `git commit`, and `git push` changes in your `dotFile` repository to save your awesome customizations!

---
# Ravi's macOS Dotfiles Setup: Your Automated Development Environment

## 1. Overview & Purpose

Welcome! This project provides a set of automated scripts to set up a consistent and powerful development environment on a macOS machine. Whether you're setting up a brand new Mac or ensuring your existing machine has the right tools, these scripts aim to streamline the process.

**The main goals are:**

* **Automation:** Reduce the manual effort involved in installing software, configuring the shell, and setting up development tools.
* **Standardization:** Ensure a consistent set of tools and configurations across different machines or setup instances.
* **Personalization:** Provide a framework for managing your personal configuration files (`dotfiles`) like shell settings, aliases, and Git configurations using version control.
* **Efficiency:** Install modern, efficient tools commonly used in software development.

This guide assumes you might be relatively new to managing macOS environments via the command line, so it includes explanations for key tools and detailed steps.

## 2. Why Use This?

Setting up a development machine involves many repetitive steps: installing tools, configuring paths, customizing the shell, managing settings, etc. Doing this manually is time-consuming and error-prone.

This project helps by:

* **Saving Time:** Automates the installation of dozens of tools and applications.
* **Reducing Errors:** Scripted processes are less prone to typos or missed steps than manual setup.
* **Version Control for Your Setup:** By keeping your configuration (`dot/` files) in a Git repository alongside these scripts, you can track changes, revert if needed, and easily replicate your setup elsewhere.
* **Learning:** Understanding these scripts can teach you more about managing your macOS environment, shell configuration, and package management.

## 3. Technology Background

This setup leverages several standard technologies:

* **Shell Scripting (Bash):** The automation is performed using scripts written for the Bash shell (though the final environment uses Zsh).
* **Homebrew:** The primary package manager for installing command-line tools and GUI applications on macOS.
* **Git:** The version control system used to manage this dotfiles repository and your own code projects.
* **Zsh (Z Shell):** A powerful shell (the default on recent macOS versions) that offers significant improvements over older shells like Bash.
* **Oh My Zsh:** A framework for managing Zsh configuration, making it easy to use themes and plugins.
* **Powerlevel10k:** A fast and highly customizable theme for Zsh, providing an informative prompt.
* **Miniconda:** A minimal installer for the `conda` package and environment manager, excellent for managing Python (and other language) packages and creating isolated project environments.
* **Symbolic Links (`ln -s`):** Used by the scripts to link your configuration files from the `dot/` directory in this repository to their expected locations in your home directory (`$HOME`). This means changes in your repository are immediately reflected in your live environment.

## 4. Repository Structure Explained

This repository is organized to separate setup logic from personal configuration:

* `.env`: **(You Create & Git Ignore!)** Stores user-specific variables like your Git name, email, and the main path for your code projects (`GIT_HOME`). It's sourced by scripts but should *not* be committed to Git if your repository is public.
* `.gitignore`: Tells Git which files/folders *within this repository* to ignore (e.g., `.env`).
* `README.md`: This file.
* `scripts/`: Contains all the numbered setup scripts (`00` to `09`) and the master runner (`run_all.sh`).
* `dot/`: **(Your Personal Config)** Contains *your* configuration files (dotfiles). The setup scripts will create symbolic links from your home directory (`$HOME`) pointing to the files inside this folder (e.g., `$HOME/.zshrc` -> `.../dotfiles/dot/.zshrc`). You customize these files!
* `python/`: Contains Python-related files, primarily your `requirements.txt` for `pip`.

## 5. Key Tools Explained (Brief Overview)

This setup installs and configures several important tools. See the **User Guide** section below for more detailed usage.

* **Homebrew:** Package manager for macOS. Installs CLI tools and GUI apps.
* **Miniconda:** `conda` environment manager, primarily for Python. Creates isolated project environments.
* **Zsh + Oh My Zsh + Powerlevel10k:** Your enhanced shell environment with themes and plugins.
* **dockutil:** Used by scripts to manage Dock icons.
* **SSH Keys:** Used for secure GitHub access.

## 6. Installed Packages

(Package tables provide a reference for what's installed)

### Core Command-Line Tools (`scripts/02_install_brew_core.sh`)

| Package                 | Description                                                                 |
| :---------------------- | :-------------------------------------------------------------------------- |
| `coreutils`             | Modern GNU versions of essential tools (`ls`, `cp`, `mv`, etc.) with more features |
| `mas`                   | Interact with the Mac App Store from the command line                       |
| `moreutils`             | Collection of useful supplementary Unix tools (`sponge`, `parallel`, etc.)  |
| `findutils`             | Modern GNU versions of `find`, `locate`, `xargs`                            |
| `gnu-sed`               | Powerful GNU stream editor (`sed`)                                          |
| `bash`                  | Latest version of the Bash shell                                            |
| `bash-completion@2`     | Enhanced programmable tab completion for Bash                               |
| `gnupg`                 | GNU Privacy Guard (GPG) for encryption and digital signatures               |
| `vim`                   | Latest version of the powerful Vi Improved text editor                      |
| `grep`                  | Modern GNU `grep` with more features than the macOS version                 |
| `ripgrep` (`rg`)        | Extremely fast tool for recursively searching directories for text patterns |
| `git`                   | Distributed version control system (latest version)                         |
| `git-lfs`               | Git extension for handling large binary files efficiently                   |
| `ssh-copy-id`           | Utility to easily install SSH public keys on remote servers                 |
| `tree`                  | Displays directory structures in a hierarchical tree format                 |
| `node`                  | JavaScript runtime environment and npm package manager                      |
| `wget`                  | Tool for downloading files from the web non-interactively                   |
| `htop`                  | Advanced, interactive system monitor and process viewer                     |
| `zsh`                   | Z shell (Installs latest version via Brew)                                  |
| `zsh-syntax-highlighting` | Adds command syntax highlighting in Zsh (as Oh My Zsh plugin)             |
| `autojump`              | Learns your directory navigation habits for faster `cd`                     |
| `zsh-autosuggestions`   | Suggests commands as you type based on history (as Oh My Zsh plugin)        |
| `dockutil`              | Command-line tool for managing macOS Dock items                             |
| `rename`                | Renames multiple files using Perl regular expressions                       |

*Note: `zsh-syntax-highlighting` and `zsh-autosuggestions` are installed as Oh My Zsh plugins in script `04`.*

### GUI Applications (`scripts/06_install_apps_cask.sh`)

| Application           | Description                                                      |
| :-------------------- | :--------------------------------------------------------------- |
| `brave-browser`       | Privacy-oriented web browser based on Chromium                   |
| `google-chrome`       | Popular web browser by Google                                    |
| `raycast`             | Extensible productivity launcher                                 |
| `visual-studio-code`  | Feature-rich source code editor with extensive extension support |
| `iterm2`              | Highly customizable terminal emulator for macOS                  |
| `warp`                | Modern terminal with integrated AI and collaborative features    |
| `docker`              | Platform for building, running, and managing containers          |
| `ngrok`               | Creates secure tunnels from public URLs to your local machine    |
| `dbeaver-community`   | Free multi-platform universal database management tool           |
| `postman`             | Collaboration platform for API development and testing           |
| `osxfuse`             | Enables third-party file systems on macOS                        |
| `zoom`                | Widely used video conferencing and online meeting application    |
| `discord`             | Popular communication platform for communities (text, voice, video) |
| `microsoft-teams`     | Business communication and collaboration platform                |
| `bitwarden`           | Secure, open-source password manager                             |
| `ollama`              | Tool to easily run large language models locally on your machine |
| `dropbox`             | Cloud file storage and synchronization service                   |
| `google-drive`        | Google's cloud file storage and synchronization service          |
| `cheatsheet`          | Utility to view keyboard shortcuts for the active application           |
| `keycastr`            | Displays your keystrokes on screen (useful for demos)            |
| `itsycal`             | Simple, small calendar display in the menu bar                   |
| `suspicious-package`  | QuickLook plugin for inspecting macOS installer package contents |
| `webpquicklook`       | QuickLook plugin enabling previews for WebP image files          |
| `betterzip`           | Powerful archiving tool supporting various compression formats   |

## 7. User Guide: Using Your New Environment

This section provides tips on using the tools and features set up by the scripts.

### Working with the Terminal (Zsh)

Your terminal is now powered by Zsh, enhanced with Oh My Zsh and Powerlevel10k.

* **The Prompt (Powerlevel10k):** Notice your command prompt looks different. It's designed to be informative!
    * It usually shows your current directory path.
    * If you're inside a Git repository, it will show the branch name, status (e.g., `?` for untracked files, `!` for modified files), and potentially the number of commits ahead/behind the remote.
    * It might show your active Python (conda/venv) or Node environment.
    * It shows different colors/icons for success or failure of the last command.
    * *Tip:* Run `p10k configure` in the terminal to customize the prompt's look and feel anytime. Your choices are saved in `~/.p10k.zsh` (linked from `dot/.p10k.zsh`).
* **Autosuggestions (`zsh-autosuggestions`):** Start typing a command you've used before. You'll see a faint suggestion for the rest of the command appear after your cursor.
    * If the suggestion is correct, press the **Right Arrow key (→)** or the `End` key to accept it and complete the command instantly.
    * If the suggestion is wrong, just keep typing; it will disappear or change.
* **Syntax Highlighting (`zsh-syntax-highlighting`):** As you type commands:
    * Valid commands often appear **green**.
    * Commands that aren't found might appear **red**.
    * Arguments, strings, and options might have different colors.
    * This helps you spot typos *before* you hit Enter.
* **Directory Jumping (`autojump`):** Instead of typing long `cd` paths:
    * Type `j <partial_name>` where `<partial_name>` is part of a directory name you visit often. Press Enter. `autojump` will jump you to the most likely match based on your history.
    * Examples: `j proj` might jump to `~/Projects`, `j dotf` might jump to `~/Projects/dotfiles`.
    * Use `j --stat` to see which directories `autojump` knows about and their "weight".
* **Aliases (`dot/.aliases`):** Use the short commands you define in your `dot/.aliases` file. For example, if you add `alias ll="ls -alFh"`, typing `ll` will run the longer `ls` command. Run `alias` in the terminal to see all currently active aliases.
* **Functions (`dot/.functions`):** Use any custom functions defined in `dot/.functions` just like regular commands.
* **Basic Navigation:**
    * `ls`: List directory contents (uses the enhanced GNU version). Try `ls -lha` for detailed, human-readable output.
    * `cd <directory>`: Change directory. `cd ..` goes up one level. `cd ~` or just `cd` goes to your home directory.
    * `pwd`: Print the current working directory path.
    * `Tab` Key: Use Tab for autocompletion of commands, filenames, and directory names. Zsh often has more advanced completion than Bash.

### Managing Software with Homebrew

* **Finding Software:** `brew search <keyword>` (e.g., `brew search mysql`, `brew search video editor`).
* **Installing:** `brew install <formula>` for CLI tools, `brew install --cask <cask>` for GUI apps.
* **Updating:** Regularly run `brew update` (to get latest package lists) followed by `brew upgrade` (to upgrade installed packages).
* **Checking Health:** If things seem off, run `brew doctor`.
* **Listing Installed:** `brew list` (CLI) and `brew list --cask` (GUI).
* **Managing Services:** Some tools run in the background (like databases). Use `brew services list` to see them, `brew services start <name>`, `brew services stop <name>`, `brew services restart <name>`.

### Managing Python with Miniconda

* **Key Idea: Environments!** Avoid installing everything into the `base` environment. Create separate environments for different projects to prevent package conflicts.
* **Workflow:**
    1.  `conda create --name my_project_env python=3.11`: Create an environment for your project.
    2.  `conda activate my_project_env`: Activate it. Your prompt will change to `(my_project_env)`.
    3.  `conda install numpy pandas matplotlib` (or `pip install ...`): Install packages *into the active environment*.
    4.  Work on your project (run `python your_script.py`, etc.).
    5.  `conda deactivate`: When finished, deactivate the environment.
* **Useful Commands:**
    * `conda env list`: See all your environments.
    * `conda list`: See packages in the active environment.
    * `conda env remove -n my_project_env`: Delete an environment.
    * `conda env export > environment.yml`: Save the package list of the current environment.
    * `conda env create -f environment.yml`: Create an environment from a saved file (great for sharing projects).

### Using Git & GitHub

* **Configuration:** Your name and email are set globally by script `03`. The global gitignore (linked from `dot/.gitignore_global`) helps ignore common temporary files.
* **SSH Key:** Script `09` sets up your SSH key. After manually adding the *public* key to GitHub (see Post-Setup Steps), you can clone, push, and pull from your repositories using the SSH URL (e.g., `git@github.com:user/repo.git`) without needing a password/token each time.
* **Basic Git Commands (with Oh My Zsh Aliases):**
    * `git clone <repo_url>`: Copy a remote repository locally.
    * `gst` (alias for `git status`): Check the status of your files.
    * `ga .` (alias for `git add .`): Stage all changes. `ga <file>` stages a specific file.
    * `gcmsg "Your commit message"` (alias for `git commit -m "..."`): Commit staged changes.
    * `gl` or `glo` (aliases for `git log` variants): View commit history.
    * `gp` (alias for `git push`): Upload your local commits to the remote repository.
    * `gl` (alias for `git pull`): Download changes from the remote repository.
* **Git LFS:** If you installed `git-lfs` and work with large files, run `git lfs install --system` once manually. Then use `git lfs track "*.psd"` (for example) to tell LFS which file types to manage.

### Other Handy Utilities

* **`rg "search term"`:** Quickly search for text within files in the current directory and subdirectories. Much faster than `grep` for codebases.
* **`sudo htop`:** View running processes interactively. Use arrow keys to navigate, `k` or `F9` to send kill signals (use carefully!). `q` or `F10` to quit.
* **`tree -L 2`:** Show the current directory structure up to 2 levels deep.
* **`mas list` / `mas search` / `mas install <id>`:** Manage Mac App Store apps from the command line.

### Using GUI Apps

* **Launching:** Use Spotlight (`Cmd+Space`), Raycast (`Option+Space` or your custom hotkey), or Launchpad (`F4` or Dock icon) to quickly find and launch installed applications like VS Code, Chrome, Docker Desktop, etc.
* **Raycast:** Explore its features! Trigger it and type things like "calculator", "calendar", "clipboard history", or search for files. Install extensions from its built-in store for more power.
* **Initial Setup:** Remember apps like Docker Desktop, Bitwarden, Dropbox, Google Drive will require you to log in or perform initial setup the first time you launch them.

## 10. Prerequisites

Before running the setup on a **new Mac**:

1.  Complete the initial macOS setup assistant (user account, Wi-Fi, etc.).
2.  Connect to the internet.
3.  Open `Terminal.app` (Applications > Utilities > Terminal).
4.  Install **Xcode Command Line Tools**: This provides `git` and essential build tools. Run the following command and follow the GUI prompts:
    ```bash
    xcode-select --install
    ```
    *(Wait for the installation to complete before proceeding).*

## 11. Step-by-Step Installation & Configuration

**Crucial:** Follow these steps carefully *before* running the main script.

1.  **Decide Your Code Directory (`GIT_HOME`):** Choose the main parent directory where you want to store your code repositories (e.g., `~/Projects`, `~/Code`, or `/Users/ravi/projects/git`).
2.  **Clone This Repository:** Clone *this specific dotfiles repository* into a subdirectory within your chosen `GIT_HOME`. For clarity, let's call the cloned folder `dotfiles`.
    ```bash
    # Example using /Users/ravi/projects/git as GIT_HOME:
    # Ensure the parent directory exists
    mkdir -p /Users/ravi/projects/git

    # Navigate into it
    cd /Users/ravi/projects/git

    # Clone this repo, naming the local folder 'dotfiles'
    # Replace <your-actual-repo-url> with the correct URL!
    git clone <your-actual-repo-url> dotfiles
    ```
    You should now have `/Users/ravi/projects/git/dotfiles/`.

3.  **Create and Configure `.env` File:** Navigate into the cloned repository (`cd /Users/ravi/projects/git/dotfiles`). Create a file named `.env` (you can copy `.env_example` if it exists) and **edit `.env`** to set the following variables accurately:
    * `GIT_HOME`: **Must match** the parent directory path you chose in step 1 (e.g., `GIT_HOME="/Users/ravi/projects/git"`). Use the full path.
    * `GIT_AUTHOR_NAME`: Your full name for Git commits.
    * `GIT_AUTHOR_EMAIL`: Your email address for Git commits.
    ```bash
    cd /Users/ravi/projects/git/dotfiles # Or your actual clone location
    # cp .env_example .env # If example exists
    nano .env # Or use your preferred editor (like 'code .env' if VS Code is installed)
    ```

4.  **Add `.env` to Repo's `.gitignore`:** Ensure the `.gitignore` file *at the root* of this dotfiles repository lists `.env` to prevent committing it.
    ```bash
    # Inside /Users/ravi/projects/git/dotfiles
    echo ".env" >> .gitignore
    # Commit this change to your dotfiles repo's .gitignore
    git add .gitignore
    git commit -m "Add .env to gitignore"
    ```

5.  **Customize `dot/` Files:** This is where you personalize your environment! Edit the files within the `dot/` directory:
    * **`.zshrc`:** **Crucial!** Ensure this file sets `ZSH_THEME="powerlevel10k/powerlevel10k"` and lists the Oh My Zsh plugins you want in the `plugins=(...)` array (e.g., `plugins=(git zsh-autosuggestions zsh-syntax-highlighting autojump)`). Add any other Zsh settings you need.
    * **`.p10k.zsh`:** To get your preferred Powerlevel10k prompt style, run `p10k configure` *once* in your terminal *after* the main setup completes. Then, copy the generated `~/.p10k.zsh` file into this `dot/` folder, replacing the placeholder. This file will then be linked on future runs.
    * **`.aliases`:** Add your custom command aliases here (e.g., `alias update="brew update && brew upgrade"`).
    * **`.functions`:** Add your custom shell functions here.
    * **`.gitignore_global`:** Add file patterns you want Git to ignore in *all* your repositories.

6.  **Customize `python/requirements.txt`:** Edit this file to list the Python packages you want installed globally into the base conda environment via `pip`.

## 12. Running the Setup (`run_all.sh`)

Once prerequisites and configuration are done:

1.  **Navigate to Script Directory:**
    ```bash
    # Use the path where you cloned the repo
    cd /Users/ravi/projects/git/dotfiles/scripts
    ```
2.  **Run the Master Script:** Choose one of the following modes:

    * **Standard Mode (Recommended for first run):** Runs all scripts sequentially, exiting immediately if any script fails.
        ```bash
        bash run_all.sh
        ```
    * **Interactive Mode:** Presents a menu allowing you to run all scripts, specific scripts (calculating dependencies automatically), or force-run a single script without dependencies (use with caution!).
        ```bash
        bash run_all.sh -i
        # Or: bash run_all.sh --interactive
        ```
        Follow the on-screen menu prompts. When selecting individual scripts, it will show you the calculated plan (including dependencies) and ask for confirmation before running. If you decline the plan for a *single* selected script, it will offer the option to force-run just that script.

3.  **Follow Prompts:** Enter your `sudo` password (for Homebrew, system changes) and potentially your user password (for `chsh` shell change) when prompted.
4.  **Wait:** The process involves downloading and installing software, which can take a significant amount of time depending on your internet connection and Mac's speed.

## 13. Post-Setup Steps

After `run_all.sh` (or selected scripts) completes successfully:

1.  **Restart Terminal:** **Crucial!** Quit your terminal application completely and reopen it, or log out of your macOS account and log back in. This ensures the new default shell (Zsh), updated PATH, sourced configurations (`.zshrc`), and conda initialization take full effect.
2.  **Add SSH Key to GitHub:** If script `09` ran and generated/found a key, follow the instructions printed at the end of its execution to copy your *public* SSH key and add it to your GitHub account settings online.
3.  **Log into Apps:** Open applications like Dropbox, Google Drive, Bitwarden, Docker Desktop, etc., and log into your accounts as needed.
4.  **Further Configuration:**
    * Install desired VS Code extensions (File > Preferences > Extensions or `Cmd+Shift+X`).
    * Configure Docker Desktop resource limits if needed.
    * Consider installing `nvm` (Node Version Manager) if you need to switch between Node.js versions frequently (`brew install nvm`).
    * Create specific conda environments for your projects (`conda create --name myproj ...`).

## 14. Troubleshooting

* **"Command not found" (e.g., `brew`, `conda`):** Ensure you've restarted your terminal after the setup. Check if the Homebrew `eval` line and conda `initialize` block are present in your `~/.zshrc` (which should be linked to `dot/.zshrc`). Verify Homebrew installation with `brew doctor`.
* **Permission Errors:** Ensure you run `run_all.sh` as your regular user. It will ask for `sudo` password when needed. Don't run the whole script *with* `sudo`.
* **Homebrew Issues:** Run `brew doctor` and follow its advice. Sometimes `brew update && brew upgrade` can fix issues.
* **Script Fails:** The `run_all.sh` script uses `set -e` in standard mode, so it should stop on the first error. Check the error message in the terminal output to identify the problematic command or script. You can try running the failed script individually for debugging (using the interactive menu in `run_all.sh` might be helpful here).

## 15. Customization

* **Add/Remove CLI Tools:** Edit the `CORE_PACKAGES` array in `scripts/02_install_brew_core.sh`.
* **Add/Remove GUI Apps:** Edit the `CASK_PACKAGES` array in `scripts/06_install_apps_cask.sh`.
* **Add/Remove macOS Settings:** Edit `scripts/07_configure_macos.sh`. Add more `defaults write` commands carefully.
* **Change Shell Config:** Edit the files in the `dot/` directory (`.zshrc`, `.p10k.zsh`, `.aliases`, `.functions`). Changes take effect in new terminal sessions due to the symbolic links.
* **Change Python Packages:** Edit `python/requirements.txt`. Re-run `bash scripts/05_setup_python.sh` (or just the `pip install` part) to update.

## 16. Disclaimer

These scripts modify system settings and install software. While reviewed for robustness, run them at your own risk. It is **highly recommended** to test the entire process on a virtual machine or a secondary, non-critical user account before running it on your primary system, especially for the first time or after making significant changes. Back up important data before proceeding.

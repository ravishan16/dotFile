# Ravi's macOS dotFile Setup: Your Automated Development Environment

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/ravishan16/dotFile?style=social)](https://github.com/ravishan16/dotFile/stargazers)

![Banner](https://raw.githubusercontent.com/ravishan16/dotFile/main/assets/banner_1.png) # macOS Development Environment Setup

This project provides scripts to automate the setup of your macOS development environment. It installs essential tools, configures your shell, and manages your personal settings (`dotFile`).

## Why Use This?

Setting up a development machine involves many repetitive steps: installing tools, configuring paths, customizing the shell, managing settings, etc. Doing this manually is time-consuming and error-prone.

This project helps by:

* **Saving Time:** Automates the installation of dozens of tools and applications.
* **Reducing Errors:** Scripted processes are less prone to typos or missed steps than manual setup.
* **Version Control for Your Setup:** By keeping your configuration (`dot/` files) in a Git repository alongside these scripts, you can track changes, revert if needed, and easily replicate your setup elsewhere.
* **Learning:** Understanding these scripts can teach you more about managing your macOS environment, shell configuration, and package management.

## Technology Background

This setup leverages several standard technologies:

* **Shell Scripting (Bash):** The automation is performed using scripts written for the Bash shell (though the final environment uses Zsh).
* **Homebrew:** The primary package manager for installing command-line tools and GUI applications on macOS.
* **Git:** The version control system used to manage this dotFile repository and your own code projects.
* **Zsh (Z Shell):** A powerful shell (the default on recent macOS versions) that offers significant improvements over older shells like Bash.
* **Oh My Zsh:** A framework for managing Zsh configuration, making it easy to use themes and plugins.
* **Powerlevel10k:** A fast and highly customizable theme for Zsh, providing an informative prompt.
* **Miniconda:** A minimal installer for the `conda` package and environment manager, excellent for managing Python (and other language) packages and creating isolated project environments.
* **Rust & Cargo:** A modern systems programming language focused on safety and performance, installed via `rustup` (script `09`). Cargo is its build tool and package manager.
* **mdBook:** A utility (installed via Cargo) used to create an online book from the Markdown guides in the `docs/` folder.
* **Symbolic Links (`ln -s`):** Used by the scripts to link your configuration files from the `dot/` directory in this repository to their expected locations in your home directory (`$HOME`). This means changes in your repository are immediately reflected in your live environment.

## Guides (Published via mdBook)

The detailed guides for installation and tool usage are maintained as Markdown files in the `/docs` directory. They are automatically built into an online book using **mdBook** and published via GitHub Actions to GitHub Pages.

**📚 [Access the Online Guides Here](https://ravishan16.github.io/dotFile/)** You can also build and view the guides locally:
1. Ensure you have Rust and `mdbook` installed (script `09_install_rust.sh` handles this).
2. Navigate to the repository root directory.
3. Run `mdbook serve --open`.

| Guide Title                                              | Description                                                                 |
|----------------------------------------------------------|-----------------------------------------------------------------------------|
| [dotFile: Installing Your Automated macOS Setup](docs/dotFile_Installation_Guide.md) | Step-by-step guide to set up your macOS environment with automation.       |
| [Managing Software with Homebrew 🍺](docs/brew_user_guide.md) | Learn how to install, update, and manage software using Homebrew.          |
| [Using Your Zsh Shell Superpowers ✨](docs/ozsh_user_guide.md) | Tips and tricks for using Zsh with Oh My Zsh, Powerlevel10k, and plugins.  |
| [Basic Git & GitHub Workflow](docs/git_user_guide.md)    | A beginner-friendly guide to using Git and GitHub for version control.     |
| [Managing Python with Conda (Miniconda)](docs/Conda_User_Guide.md) | Guide to managing Python environments and packages with Conda.             |
| [Basic Docker Maintenance 🐳🧹](docs/docker_user_guide.md) | Learn how to prune and clean up Docker containers, images, and volumes.    |
| [Your Terminal Command Center (iTerm2) 💻](docs/iterm_user_guide.md) | Guide to customizing and using iTerm2 for an efficient terminal experience.|
| [Rust Essentials Guide 🦀](docs/rust_essentials_guide.md) | Quick reference for essential Rust and Cargo commands.                     |
| [Mac Keyboard Shortcut Cheat Sheet ⚡️](docs/mac_cheatsheet.md) | A handy list of keyboard shortcuts to boost your productivity on macOS.    |
| [Basic Mac Housekeeping 🧹✨](docs/mac_user_guide.md)     | Tips for keeping your Mac clean, organized, and running smoothly.          |
| [Custom Shell Aliases & Functions 🛠️](docs/custom_alias_userguide.md) | Learn how to create and use custom aliases and functions in your shell.    |

## 1. Installation & Setup

Follow these steps after cloning your fork.

### 1.1. Prerequisites (Do This First on a New Mac)

1.  **Complete macOS Setup:** Finish the initial macOS setup assistant (create user, connect to Wi-Fi, etc.).
2.  **Install Xcode Command Line Tools:** Open `Terminal.app` (Applications > Utilities > Terminal). Run this command and follow the on-screen prompts (accept the license, click install):
    ```bash
    xcode-select --install
    ```
    Wait for the installation to complete before proceeding.

### 1.2. Initial Configuration (Prepare Your Settings)

**Crucial:** Configure these files *within your cloned repository* before running the setup.

1.  **Fork the Repository:**
    * **Why Fork?** Forking creates your own personal copy of this repository under your GitHub account. This allows you to save your customizations (like your specific dotFile, package lists, `.env` file content) without affecting the original project.
    * **How:** Go to the main page of the original repository on GitHub. Click the "Fork" button near the top-right. Choose your GitHub account as the owner for the fork.

2.  **Clone Your Fork:** Now, download the code from *your forked repository* to your local Mac.
    * **Choose Location:** Decide where you want to store your code projects (e.g., `~/Projects`, `~/Code`, `~/projects/git`). This will be your `GIT_HOME`.
    * **Clone Command:** Open Terminal and run `git clone`, replacing `<your-fork-url>` with the SSH or HTTPS URL of *your forked repository* (get it from the "Code" button on your fork's GitHub page). It's recommended to name the local directory `dotFile`.

    ```bash
    # Example: If your chosen code directory is ~/projects/git
    # Ensure the parent directory exists first
    mkdir -p ~/projects/git

    # Navigate into it
    cd ~/projects/git

    # Clone YOUR FORK, naming the local folder 'dotFile'
    # Replace <your-fork-url> with the actual URL from YOUR fork!
    git clone <your-fork-url> dotFile
    ```
    * You now have the setup files locally, typically at `~/projects/git/dotFile/`.

3.  **Create & Edit `.env` File:** This file stores your personal settings.
    * Create the file (copy the example if it exists): `cp .env_example .env` (or `touch .env`).
    * Open the `.env` file: `nano .env` (or `code .env` etc.)
    * Set the variables **accurately**:
        * `GIT_HOME`: **Must** be the full path to the directory where you cloned this repo's *parent* (e.g., `GIT_HOME="~/projects/git"` if you cloned into `~/projects/git/dotFile`).
        * `GIT_AUTHOR_NAME`: Your full name for Git commits.
        * `GIT_AUTHOR_EMAIL`: Your email address for Git commits.
    * Save and close (`nano`: `Ctrl+O`, Enter, `Ctrl+X`).

3.  **Ignore `.env`:** Prevent committing secrets. Ensure `.env` is listed in your repository's `.gitignore` file.
    ```bash
    echo ".env" >> .gitignore
    # Commit this change to your fork
    git add .gitignore
    git commit -m "Add .env to gitignore"
    ```

4.  **Customize `dot/` Files:** Edit the files inside the `dot/` subfolder to match your preferences:
    * **`dot/.zshrc`:** Configure your Zsh shell (Theme, Plugins, PATHs, etc.). Ensure `plugins=(...)` includes `git zsh-autosuggestions zsh-syntax-highlighting autojump` plus any others you want.
    * **`dot/.p10k.zsh`:** Set up your Powerlevel10k prompt style. Run `p10k configure` in the terminal *after* setup, then copy the generated `~/.p10k.zsh` file into this `dot/` folder.
    * **`dot/.aliases`:** Add your command shortcuts.
    * **`dot/.functions`:** Add your shell functions.
    * **`dot/.gitignore_global`:** Define global Git ignore patterns.

5.  **Customize `python/requirements.txt`:** List Python packages for `pip` to install into the base conda environment.

### 1.3. Running the Setup (`run_all.sh`)

1.  **Navigate to Script Directory:**
    ```bash
    # Use the path where you cloned the repo
    cd ~/projects/git/dotFile/scripts
    ```
2.  **Execute `run_all.sh`:** Choose a mode:
    * **Interactive Mode (Select Scripts):** Shows a menu to choose specific scripts (0-9) or `all`. **Warning:** Selecting individual scripts runs *only* those scripts; dependencies are NOT automatically included. Use with caution.
        ```bash
        bash run_all.sh
        ```
        ![runall](https://raw.githubusercontent.com/ravishan16/dotFile/main/assets/runall.png) 
3.  **Follow Prompts:** Enter your `sudo` password and potentially your user password (`chsh`) when requested.
4.  **Wait:** Installation takes time.

### 1.4. Post-Setup Actions (Required)

1.  **Restart Terminal:** **Crucial!** Quit and reopen your terminal, or log out/in.
2.  Add SSH Key to GitHub: If script `08` ran, copy the public key it printed and add it to your GitHub account settings online.
3.  **Log into Apps:** Launch and log into GUI apps (Docker, Bitwarden, Dropbox, etc.).
4.  **Final Configurations:** Install VS Code extensions, configure Docker, etc.

## 2. How This Repository Works
* **Goal:** Automate macOS development setup.
* **Method:** Uses shell scripts (`scripts/`) for automation. Manages personal config files (`dot/`) via symbolic links.
* **Configuration:** Uses `.env` for variables, `dot/` for linked configs, `python/` for pip requirements. `run_all.sh` orchestrates the `scripts/`.

## 3. Repository Structure Explained

This repository is organized to separate setup logic from personal configuration:

* `.env`: **(You Create & Git Ignore!)** Stores user-specific variables like your Git name, email, and the main path for your code projects (`GIT_HOME`). It's sourced by scripts but should *not* be committed to Git if your repository is public.
* `.gitignore`: Tells Git which files/folders *within this repository* to ignore (e.g., `.env`).
* `README.md`: This file.
* `.github/`: Contains GitHub Actions workflows (e.g., mdBook deployment).
* `docs/`: Source Markdown files for the `mdBook` guides.
    * `SUMMARY.md`: Table of contents for the guides.
* `dot/`: **(Your Personal Config)** Contains *your* configuration files (dotFile). The setup scripts will create symbolic links from your home directory (`$HOME`) pointing to the files inside this folder (e.g., `$HOME/.zshrc` -> `.../dotFile/dot/.zshrc`). You customize these files!
* `scripts/`: Contains all the numbered setup scripts (`00` to `09`), the master runner (`run_all.sh`), and helper files (`helpers.sh`).
* `python/`: Contains Python-related files, primarily your `requirements.txt` for `pip`.
* `book.toml`: Configuration file for `mdBook`.

## 4. Key Tools Explained (Brief Overview)

This setup installs and configures several important tools. See the **Guides** section above for more detailed usage.

* **Homebrew:** Package manager for macOS. Installs CLI tools and GUI apps.
* **Miniconda:** `conda` environment manager, primarily for Python. Creates isolated project environments.
* **Zsh + Oh My Zsh + Powerlevel10k:** Your enhanced shell environment with themes and plugins.
* **Rust + Cargo:** Modern systems language and build tool/package manager (installed via `rustup` in script `09`).
* **mdBook:** Tool to create online books from Markdown (used for the Guides).
* **dockutil:** Used by scripts to manage Dock icons.
* **SSH Keys:** Used for secure GitHub access.

## 5. Installed Packages

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

*Note: `zsh-syntax-highlighting` and `zsh-autosuggestions` are installed as Oh My Zsh plugins in script `04`. Rust is installed via `rustup` in script `09`.*

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
| `zoom`                | Widely used video conferencing and online meeting application    |
| `discord`             | Popular communication platform for communities (text, voice, video) |
| `microsoft-teams`     | Business communication and collaboration platform                |
| `bitwarden`           | Secure, open-source password manager                             |
| `ollama`              | Tool to easily run large language models locally on your machine |
| `dropbox`             | Cloud file storage and synchronization service                   |
| `google-drive`        | Google's cloud file storage and synchronization service          |
| `keycastr`            | Displays your keystrokes on screen (useful for demos)            |
| `itsycal`             | Simple, small calendar display in the menu bar                   |
| `suspicious-package`  | QuickLook plugin for inspecting macOS installer package contents |
| `webpquicklook`       | QuickLook plugin enabling previews for WebP image files          |
| `betterzip`           | Powerful archiving tool supporting various compression formats   |

## 6. Troubleshooting

* **"Command not found" (e.g., `brew`, `conda`, `cargo`):** Ensure you've restarted your terminal after the setup. Check if the Homebrew `eval` line and conda `initialize` block are present in your `~/.zshrc` (which should be linked to `dot/.zshrc`). Verify Homebrew installation with `brew doctor`. Ensure `$HOME/.cargo/bin` is in your PATH (script `09` attempts this).
* **Permission Errors:** Ensure you run `run_all.sh` as your regular user. It will ask for `sudo` password when needed. Don't run the whole script *with* `sudo`.
* **Homebrew Issues:** Run `brew doctor` and follow its advice. Sometimes `brew update && brew upgrade` can fix issues.
* **Script Fails:** The `run_all.sh` script uses `set -e`, so it should stop on the first error. Check the error message in the terminal output to identify the problematic command or script. You can try running the failed script individually for debugging (using the interactive menu in `run_all.sh` might be helpful here).

## 7. Customizing Your Setup
* **CLI Tools:** Edit the `CORE_PACKAGES` array in  `scripts/02_install_brew_core.sh`.
* **GUI Apps:** Edit the `CASK_PACKAGES` array in `scripts/06_install_apps_cask.sh`.
* **Shell:** Edit the files in the `dot/` directory (`.zshrc`, `.p10k.zsh`, `.aliases`, `.functions`). Changes take effect in new terminal sessions due to the symbolic links.
* **Prompt:** Run `p10k configure`, then copy `~/.p10k.zsh` to `dot/.p10k.zsh`.
* **Python:** Edit `python/requirements.txt`. Re-run script `05`.
* **macOS:** Edit `scripts/07_configure_macos.sh`. Re-run script `07`. Add more `defaults write` commands carefully.
* **Git/Project Path:** Edit `.env`. Re-run script `01` and potentially `03`.

## 8. Disclaimer

These scripts modify system settings and install software. While reviewed for robustness, run them at your own risk. It is **highly recommended** to test the entire process on a virtual machine or a secondary, non-critical user account before running it on your primary system, especially for the first time or after making significant changes. Back up important data before proceeding.

## Contributing
We welcome contributions! Please see our contributing guidelines for details on how to submit pull requests, report issues, and contribute to development.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

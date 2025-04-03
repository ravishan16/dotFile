# Automate Your Mac Setup: A Developer’s Guide

![Banner](..\assets\banner_2.png)

Setting up a new Mac for development can be tedious. Installing tools, configuring the shell, and tweaking settings by hand often takes hours and can vary between machines. After years of doing this manually across multiple devices, I created an automated setup to handle it more efficiently.

This post outlines a tool that cuts Mac setup time to about an hour. It’s something I’ve used myself and shared with others, like when I set up my son’s Mac mini. You can find it on GitHub at ravishan16/dotFile. Feel free to try it, tweak it, or suggest improvements.

**Why Automate?**

Manual setups have drawbacks. Automation offers a few clear advantages:

* **Saves Time:** Drops setup from several hours to roughly one by handling repetitive tasks.
* **Keeps Things Consistent:** Applies the same configuration every time, avoiding differences between machines.
* **Simplifies Replication:** Makes it easy to set up new devices or assist someone else.
* **Tracks Changes:** Uses Git to manage your environment, so you can see or undo modifications.
* **Speeds Recovery:** Re-runs quickly if you reset your system.
* **Teaches Skills:** Shows how shell scripting and configuration work if you dig into the code.

These points come from real experience, not hypotheticals.

**What’s in the Setup?**

The repository (ravishan16/dotFile) includes scripts and files to automate a developer environment on macOS. Here’s what it covers:

* **`Installation Scripts (scripts/):`**
    * **Homebrew:** Manages CLI tools and GUI apps.
    * **CLI Tools:** Adds `git`, `node`, `ripgrep`, and more (check `02_install_brew_core.sh`).
    * **GUI Apps:** Installs VS Code, iTerm2, Docker, Raycast, etc. (see `06_install_apps_cask.sh`).
    * **Shell Setup:** Installs Zsh with Oh My Zsh and plugins like `zsh-autosuggestions`, `zsh-syntax-highlighting`, and `autojump` for a better terminal.
    * **Python:** Sets up Miniconda for isolated Python environments.
    * **Git & SSH:** Configures Git and creates SSH keys for GitHub access.
* **`Dotfiles (dot/):`**
    * Includes `.zshrc`, `.aliases`, `.gitignore_global`, and others.
    * Symlinks these to your home directory so updates in the repo apply instantly.
* **`Docs (docs/):`**
    * Offers guides on Homebrew, Zsh, Git, Conda, Docker, and macOS shortcuts.

It’s a straightforward package to get a working dev setup with minimal effort.

**Guides Included**

To help you get the most out of the setup and the tools installed, the repository includes these guides:

| Guide Title                                              | Description                                                                 |
|----------------------------------------------------------|-----------------------------------------------------------------------------|
| [dotFile: Installing Your Automated macOS Setup](docs/dotFile_Installation_Guide.md) | Step-by-step guide to set up your macOS environment with automation.       |
| [Managing Software with Homebrew 🍺](docs/brew_user_guide.md) | Learn how to install, update, and manage software using Homebrew.          |
| [Using Your Zsh Shell Superpowers ✨](docs/ozsh_user_guide.md) | Tips and tricks for using Zsh with Oh My Zsh, Powerlevel10k, and plugins.  |
| [Basic Git & GitHub Workflow](docs/git_user_guide.md)    | A beginner-friendly guide to using Git and GitHub for version control.     |
| [Managing Python with Conda (Miniconda)](docs/Conda_User_Guide.md) | Guide to managing Python environments and packages with Conda.             |
| [Basic Docker Maintenance 🐳🧹](docs/docker_user_guide.md) | Learn how to prune and clean up Docker containers, images, and volumes.    |
| [Your Terminal Command Center (iTerm2) 💻](docs/iterm_user_guide.md) | Guide to customizing and using iTerm2 for an efficient terminal experience.|
| [Mac Keyboard Shortcut Cheat Sheet ⚡️](docs/mac_cheatsheet.md) | A handy list of keyboard shortcuts to boost your productivity on macOS.    |
| [Basic Mac Housekeeping 🧹✨](docs/mac_user_guide.md)     | Tips for keeping your Mac clean, organized, and running smoothly.          |
| [Custom Shell Aliases & Functions 🛠️](docs/custom_alias_userguide.md) | Learn how to create and use custom aliases and functions in your shell.    |

**How to Run It**

Here’s how to use the setup on your Mac:

1.  **Fork the Repo:** Go to `ravishan16/dotFile` and fork it to your account.
2.  **Clone It:** Pull it down to your machine:
    ```bash
    mkdir -p ~/projects/git
    cd ~/projects/git
    git clone <your-fork-url> dotFile
    ```
3.  **`Set Up .env:`** Copy the example and fill it in:
    ```bash
    cp .env_example .env # Or touch .env if no example exists
    nano .env
    ```
    Add:
    ```text
    GIT_HOME="~/projects/git" # Adjust if you cloned elsewhere
    GIT_AUTHOR_NAME="Your Name"
    GIT_AUTHOR_EMAIL="your.email@example.com"
    ```
4.  **Edit Dotfiles:** Tweak `dot/.zshrc`, `dot/.aliases`, or others to fit your needs.
5.  **Run the Script:** Go to the scripts folder and start it:
    ```bash
    cd ~/projects/git/dotFile/scripts
    bash run_all.sh
    ```
    Pick "all" from the menu and enter your password when asked.

    ![runall](..\assets\runall.png)
    
6.  **Finish Up:**
    * Restart your terminal.
    * Add the SSH key to GitHub (script will guide you).
    * Log into any GUI apps like Docker.

After this, your Mac will have a configured dev environment, including Zsh with Oh My Zsh and plugins.

**How to Customize**

You can adjust the setup to suit your workflow:

* **Change Tools:** Edit `02_install_brew_core.sh` for CLI tools or `06_install_apps_cask.sh` for apps.
* **Tune the Shell:** Modify `dot/.zshrc` for Zsh settings or `dot/.p10k.zsh` for the prompt (run `p10k configure` to update it).
* **Update Python:** Adjust `python/requirements.txt` and re-run script `05` for Conda packages.

Forking the repo lets you make it your own.

**Get Involved**

This setup works for me, but it’s better with input from others. Here’s how you can help:

* **Fork It:** Adapt it for yourself.
* **Submit Pull Requests:** Share fixes or new features.
* **Open Issues:** Flag bugs or ideas.
* **Give Feedback:** Tell me what’s useful or what’s not.

Contributions keep it practical and relevant.

**Wrapping Up**

Automating your Mac setup cuts down on time and hassle. This tool gets you a consistent dev environment with Zsh, Oh My Zsh, and plugins included, so you can focus on coding.

Check it out: `ravishan16/dotFile`

If it helps or you’ve got thoughts, let me know. I’d like to see it grow into something developers can rely on.

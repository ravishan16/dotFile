# User Guide: Setting Up Your Mac Development Environment 🚀

This guide will help you use the `dotFile` scripts to set up your Mac for development. Follow these steps to install tools, configure settings, and get ready to code!

---

## Prerequisites: Things to Do First ✅

Before starting, make sure you've completed these steps:

1. **Set Up Your Mac:** Complete the macOS startup wizard (language, Wi-Fi, Apple ID, user account).
2. **Connect to the Internet:** Ensure your Mac is online.
3. **Open Terminal:** Go to `Applications > Utilities` and open `Terminal.app`.
4. **Install Xcode Command Line Tools:**
    * These tools are required for Homebrew and other installations.
    * Run this command in Terminal:
        ```bash
        xcode-select --install
        ```
    * A pop-up window will appear. Click "Install" and agree to the terms.
    * Wait for the installation to finish completely before moving on.

---

## Step 1: Choose a Folder for Your Code (`GIT_HOME`) 📂

Decide where you want to store all your coding projects. Common choices are `~/projects/git` or `~/Code`. For this guide, we'll use `~/projects/git`.

---

## Step 2: Download the `dotFile` Repository 📥

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


3. Your Terminal prompt should now show you're inside `~/Projects/dotFile`.

---

## Step 3: Create Your Secret `.env` File 🤫

This file stores your personal information (like your Git name and email). Follow these steps:

1. Make sure you're inside the `dotFile` folder:
    ```bash
    # Example: If your chosen code directory is ~/projects/git
    cd ~/Projects/dotFile
    ```
2. Create the `.env` file:
    ```bash
    touch .env
    ```
3. Open the file for editing:
    ```bash
    nano .env
    ```
4. Add the following lines, replacing the placeholders with your actual details:
    ```env
    # --- REQUIRED ---
    # Path to your code folder
    GIT_HOME="/Users/your_mac_username/projects/git"

    # Your name for Git commits
    GIT_AUTHOR_NAME="Your Name"

    # Your email for Git commits
    GIT_AUTHOR_EMAIL="your.email@example.com"
    ```
    * Replace `your_mac_username` with your macOS username.
    * Double-check the `GIT_HOME` path is correct.
5. Save and exit `nano`:
    * Press `Ctrl+X`, type `Y`, and press `Enter`.

---

## Step 4: Prevent `.env` from Being Shared 🚫

To ensure your `.env` file isn't accidentally shared:

1. Run this command:
    ```bash
    echo ".env" >> .gitignore
    ```
2. *(Optional)* Save this change to your repository:
    ```bash
    git add .gitignore
    git commit -m "Ignore .env file"
    ```

---

## Step 5: Customize Your Settings 🛠️

The `dot/` folder contains configuration files that will be applied to your system. Review and edit them as needed:

1. **Check `dot/.zshrc`:**
    * Ensure the `plugins=(...)` line includes useful plugins like:
        ```bash
        plugins=(git zsh-autosuggestions zsh-syntax-highlighting autojump)
        ```
    * Set the theme to:
        ```bash
        ZSH_THEME="powerlevel10k/powerlevel10k"
        ```
2. **Edit `dot/.aliases`:**
    * Add shortcuts for commands you use often.
3. **Edit `dot/.gitignore_global`:**
    * Add patterns to ignore files globally, like:
        ```bash
        *.log
        .DS_Store
        ```

---

## Step 6: (Optional) Customize Python Packages 🐍

If you use Python, check `python/requirements.txt`. Add or remove libraries you want installed by default.

---

## Step 7: Run the Setup Script ✨ (`run_all.sh`)

1.  **Navigate to Script Directory:**
    ```bash
    # Use the path where you cloned the repo
    cd ~/projects/git/dotFile/scripts
    ```
2.  **Execute `run_all.sh`:** Choose a mode:
    * **Interactive Mode (Select Scripts):** Shows a menu to choose specific scripts (0-8) or `all`. **Warning:** Selecting individual scripts runs *only* those scripts; dependencies are NOT automatically included. Use with caution.
        ```bash
        bash run_all.sh
        ```
        ![runall](..\assets\runall.png)

3.  **Follow Prompts:** Enter your `sudo` password and potentially your user password (`chsh`) when requested.

4.  **Wait:** Installation takes time.

---

## Final Steps After Installation 🏁

1. **Restart Your Terminal:** Quit Terminal completely (`Cmd+Q`) and reopen it. This ensures all settings are applied.
2. **Add SSH Key to GitHub:** If script `08` ran, copy the public key it printed and add it to your GitHub account settings online.
    * Copy your public SSH key:
        ```bash
        cat ~/.ssh/id_ed25519.pub
        ```
    * Add it to your GitHub account: `Settings > SSH and GPG keys > New SSH key`.
3. **Log into Apps:** Open and sign into apps like Docker, Dropbox, and Google Drive.
4. **Explore Your Setup:** Start using tools like Conda, Git, and Zsh plugins. Customize VS Code and other tools as needed.

---

You're all set! Enjoy your streamlined Mac development environment. 🎉
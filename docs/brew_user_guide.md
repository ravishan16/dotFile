# User Guide: Managing Software with Homebrew 🍺

Homebrew is like an App Store for your terminal. It makes installing, updating, and removing software easy. Whether you need command-line tools or Mac apps, Homebrew handles it all without dragging `.dmg` files around.

## What Can Homebrew Do? 🤔

Homebrew installs two types of software:

1. **Formulas:** Command-line tools like `git`, `python`, or `tree`. These tools run in the terminal.
    * **Install with:** `brew install <formula_name>`
2. **Casks:** Mac apps like Google Chrome, VS Code, or Spotify. These apps appear in your `/Applications` folder.
    * **Install with:** `brew install --cask <cask_name>`

## Everyday Homebrew Commands 🚀

Here are the most common commands you'll use:

### 1. Keep Homebrew Updated
* **Update Homebrew's Catalog:** Refresh the list of available software.
    ```bash
    brew update
    ```
* **Upgrade Installed Software:** Update all tools and apps installed via Homebrew.
    ```bash
    brew upgrade
    ```
* **Do Both Together:**
    ```bash
    brew update && brew upgrade
    ```

### 2. Install Software
* **Install a Command-Line Tool (Formula):**
    ```bash
    brew install <formula_name>
    # Examples:
    brew install tree    # Shows directory structures
    brew install htop    # Advanced activity monitor
    brew install jq      # Processes JSON data
    ```
* **Install a Mac App (Cask):**
    ```bash
    brew install --cask <cask_name>
    # Examples:
    brew install --cask firefox         # Installs Firefox browser
    brew install --cask slack           # Installs Slack messaging app
    brew install --cask rectangle       # Installs Rectangle window manager
    ```

### 3. Manage Installed Software
* **See What's Installed:**
    ```bash
    brew list          # Lists installed command-line tools
    brew list --cask   # Lists installed Mac apps
    ```
* **Get Info About a Package:**
    ```bash
    brew info <formula_name>
    brew info --cask <cask_name>
    # Examples:
    brew info git
    brew info --cask visual-studio-code
    ```
* **Uninstall Software:**
    ```bash
    brew uninstall <formula_name>
    brew uninstall --cask <cask_name>
    # Examples:
    brew uninstall tree
    brew uninstall --cask firefox
    ```

### 4. Clean Up
* **Remove Old Files:** Free up disk space by deleting old versions of software.
    ```bash
    brew cleanup
    ```
    * **Example Output:**
        ```
        Removing: /opt/homebrew/Cellar/node/18.15.0... (X files, Y MB)
        ==> Pruning caches
        Removed X files and Y MB
        ```

### 5. Troubleshooting
* **Check for Problems:** If something isn't working, run this command. It often tells you how to fix issues.
    ```bash
    brew doctor
    ```
    * **Example Output:**
        ```
        Your system is ready to brew.
        ```

### 6. Manage Background Services
Some tools (like databases) can run in the background.

* **List Services:**
    ```bash
    brew services list
    ```
* **Start a Service:**
    ```bash
    brew services start <service_name>
    # Example:
    brew services start redis
    ```
* **Stop a Service:**
    ```bash
    brew services stop <service_name>
    ```
* **Restart a Service:**
    ```bash
    brew services restart <service_name>
    ```

## Searching for Software 🔍
Not sure if Homebrew has what you need? Search for it:
```bash
brew search <keyword>
# Examples:
brew search mysql        # Search for MySQL database
brew search image editor # Search for image editing tools/apps
brew search node         # Search for Node.js
```

## Pro Tip: Run Updates Regularly
Keep your tools fresh by running:
```bash
brew update && brew upgrade
```

Homebrew makes managing software on your Mac simple and efficient. Dive in and explore!
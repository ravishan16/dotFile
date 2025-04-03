# User Guide: Using Your Zsh Shell Superpowers ✨

Your Mac's terminal isn't just a black box anymore! It's running **Zsh (Z Shell)**, turbocharged with **Oh My Zsh** (a configuration manager), the **Powerlevel10k** theme (for that cool prompt!), and some handy **plugins**. Think of it as upgrading your car's engine and dashboard.

---

## Your Smart Prompt (Powerlevel10k) 📟

That colorful line where you type commands? It's packed with useful information:

* **📍 Current Directory:** Shows where you are in your file system (e.g., `~/Projects/my-app`).
* **🌱 Git Status:** If you're in a Git project folder, it shows:
    * The current branch name (e.g., `main`, `feature-branch`).
    * Symbols indicating changes:
        * `?` - Untracked files (new files not added to Git yet).
        * `!` - Modified files (files you’ve changed but not staged).
        * `+` - Staged files (files ready to commit).
        * Arrows - Whether your branch is ahead or behind the remote branch.
* **🐍 Python Environment:** Displays the name of the active Python/Conda environment (e.g., `(my_env)`).
* **✅ / ❌ Command Status:** Shows whether your last command succeeded (✅) or failed (❌).

### Customize Your Prompt
Want to change how your prompt looks? Run this command in your terminal:

```bash
p10k configure
```

Follow the wizard to customize your prompt. Your choices are saved in `~/.p10k.zsh` (linked from `dot/.p10k.zsh`).

---

## Zsh Plugins: Your Terminal Assistants 🤖

Plugins add extra features to your terminal. Your `dot/.zshrc` file enables these plugins by default:

---

### 1. **`git` Plugin**
This plugin makes working with Git faster by providing shortcuts (aliases) for common commands. Here are some examples:

* `gst` → `git status` (Check the status of your repository.)
* `ga` → `git add` (Stage changes for commit.)
* `gcmsg` → `git commit -m` (Commit changes with a message.)
* `gp` → `git push` (Push your changes to the remote repository.)
* `gl` → `git pull` (Pull the latest changes from the remote repository.)
* `gco` → `git checkout` (Switch branches.)

For example:
```bash
$ gst
# Shows the status of your Git repository.

$ ga file.txt
# Stages 'file.txt' for commit.

$ gcmsg "Added new feature"
# Commits the staged changes with the message "Added new feature."
```

---

### 2. **`zsh-autosuggestions`**
This plugin predicts the command you're typing based on your history and shows it as a faint suggestion.

#### Example:
```bash
$ git c                                # You type this
$ git commit -m "Initial commit"       # Faint suggestion appears
```

#### Actions:
* **To Accept the Suggestion:** Press the **Right Arrow key (→)** or `End` key.
* **To Ignore the Suggestion:** Keep typing your intended command. The suggestion will disappear or change.

---

### 3. **`zsh-syntax-highlighting`**
This plugin highlights your commands as you type, helping you catch errors before running them.

#### Examples:
1. **Valid Command:**
    ```bash
    $ git status
    # 'git' is green (valid command), 'status' might be green/white.
    ```

2. **Invalid Command:**
    ```bash
    $ gti
    # 'gti' appears red (command not found).
    ```

3. **Command with Arguments:**
    ```bash
    $ echo "Hello World"
    # 'echo' is green (valid command), "Hello World" is yellow (string).
    ```

This visual feedback helps you avoid typos and mistakes.

---

### 4. **`autojump` (`j`)**
This plugin lets you jump to frequently visited directories with a single command.

#### How It Works:
`autojump` remembers directories you’ve visited before. Instead of typing a long `cd` command, you can use a keyword to jump to the directory.

#### Example:
If you often go to this directory:
```bash
cd ~/Projects/Clients/SuperCorp/WebsiteProject/src/css
```
You can simply type:
```bash
j css
```
or:
```bash
j Website
```
`autojump` will take you to the most likely match based on your history.

#### Check Learned Directories:
To see which directories `autojump` remembers, run:
```bash
j --stat
```

Example output:
```bash
10.0: /Users/you/Projects/dotFile
25.5: /Users/you/Downloads
31.2: /Users/you/Projects/WebsiteProject/src/css
-------------------------------------------------
Total weight: 66.7. Total entries: 3.
```
*(Higher weight means you visit it more often.)*

---

## Ensuring Plugins Are Enabled
To make sure these plugins are active, check the `plugins=(...)` line in your `dot/.zshrc` file. It should include:

```bash
plugins=(git zsh-autosuggestions zsh-syntax-highlighting autojump)
```

---

## Additional Tips for Beginners

### Reload Your Zsh Configuration
If you make changes to your `dot/.zshrc` file, reload it without restarting your terminal:

```bash
source ~/.zshrc
```

### Learn More About Plugins
Each plugin has its own set of features. Check their documentation for more advanced usage:
* [Oh My Zsh Git Plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git)
* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
* [autojump](https://github.com/wting/autojump)

---

These features make your terminal faster, smarter, and easier to use. Enjoy your Zsh superpowers! 🚀
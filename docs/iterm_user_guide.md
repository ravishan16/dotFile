# User Guide: Your Terminal Command Center (iTerm2) 💻

The **terminal** is your tool for controlling your Mac using text commands. Forget clicking menus – here, you type! This guide focuses on **iTerm2**, a powerful and customizable alternative to the basic Mac `Terminal.app`. Inside iTerm2, your **shell** (configured as **Zsh**) helps you run commands efficiently.

## Why Use iTerm2? 🤔

iTerm2 makes working in the terminal easier and more productive with features like:

* **Tabs:** Open multiple terminal sessions in one window (`Cmd + T` for a new tab).
* **Panes:** Split a single tab into multiple sections to run commands side-by-side (`Cmd + D` for vertical split, `Cmd + Shift + D` for horizontal split).
* **Custom Looks:** Change colors, fonts, and transparency to suit your style (`Cmd + ,` to open settings).
* **Search:** Quickly find text in your terminal output (`Cmd + F`).
* **Profiles:** Save different settings for different tasks.

## How to Open iTerm2 🚀

You can launch iTerm2 just like any other app:

1. **Spotlight Search:** Press `Cmd + Space`, type `iTerm`, and press Enter.
2. **Applications Folder:** Open `/Applications` and double-click `iTerm`.

## Understanding the iTerm2 Window 👀

Here’s what you’ll see when you open iTerm2:

* **The Prompt:** This is where you type commands. It usually ends with `$`. Your **Powerlevel10k** prompt shows helpful info like your current folder and Git status:
    ```
    ╭─ ravi@Raviss-MacBook-Pro ~/Projects/dotFile (main ✔)
    ╰─ $ _
    ```
    *(In this example, the user `ravi` is in the folder `~/Projects/dotFile`, on the Git branch `main` with no changes (`✔`), ready to type a command (`$`).)*
* **Cursor:** The blinking underscore `_` or block shows where your typing will appear.
* **Tabs:** Like browser tabs, they let you open multiple terminal sessions (`Cmd + T` for new, `Cmd + W` to close).
* **Panes:** Split your terminal into sections to multitask:
    * `Cmd + D`: Split the current pane vertically.
    * `Cmd + Shift + D`: Split the current pane horizontally.
    * `Cmd + ]` or `Cmd + [`: Switch between panes.
    * `Cmd + W`: Close the current pane.

## Basic Commands and Shortcuts ⌨️

Here are some essential commands and shortcuts to get started:

### Running Commands
* **Execute:** Type a command (e.g., `ls -lha` or `pwd`) and press **Enter**.
* **Stop a Command:** If a command is stuck, press **`Ctrl + C`** to interrupt it.

### Navigating and Autocompleting
* **Tab Completion:** Start typing a command, file, or folder name, then press **`Tab`**:
    * If there’s one match, it completes automatically.
    * If there are multiple matches, it shows a list. Press `Tab` again to cycle through them.
    * *Example:* Type `cd Proj` and press `Tab`. It might complete to `cd Projects/`.

* **Command History:**
    * Use the **Up Arrow** to see previous commands.
    * Use the **Down Arrow** to move forward in history.
    * Press **`Ctrl + R`**, then type part of an old command to search your history. Press Enter to run it or `Ctrl + C` to cancel.

### Clearing the Screen
* **`Ctrl + L`:** Clears the visible terminal screen (scroll up to see previous output).
* **`Cmd + K`:** Clears the entire scrollback buffer (everything above is gone).
* **`clear`:** Typing this and pressing Enter does the same as `Ctrl + L`.

### Copying and Pasting
* **Copy:** Select text with your mouse. In iTerm2, selecting text usually copies it automatically (check settings). Otherwise, use `Cmd + C`.
* **Paste:** Press `Cmd + V`.

## Practice and Explore! 🎉

The terminal is a powerful tool once you get the hang of it. Start with these basics, and don’t be afraid to experiment (safely). For more commands, check out the "Basic Terminal Commands" guide.
# User Guide: Basic Mac Housekeeping 🧹✨

Keeping your Mac tidy and running smoothly doesn’t have to be complicated. Think of it like cleaning your room—just a few simple habits can make a big difference. Follow these steps to keep your Mac fast, secure, and clutter-free.

---

## 1. Keep Your Software Up-to-Date 🔄

Outdated software can slow down your Mac or leave it vulnerable to security issues. Here’s how to stay updated:

### macOS Updates
1. Click the **Apple Menu ()** in the top-left corner of your screen.
2. Select **System Settings**.
3. Go to **General > Software Update**.
4. Install any available updates.

### Homebrew Updates (Command-Line Tools)
If you use Homebrew to install apps and tools, keep them updated regularly. Open your terminal (e.g., iTerm2 or Terminal) and run:
```bash
brew update && brew upgrade
```
- `brew update`: Updates the list of available software.
- `brew upgrade`: Updates all installed tools and apps to the latest versions.

### App Store Updates
1. Open the **App Store**.
2. Click **Updates** in the sidebar.
3. Install any available updates for your apps.

Alternatively, if you use the `mas` command-line tool (installed via Homebrew), you can update App Store apps directly from the terminal:
```bash
mas outdated  # Lists apps with updates available
mas upgrade   # Updates all outdated apps
```

---

## 2. Clean Up Files and Free Up Space 💾

Digital clutter can slow down your Mac. Here’s how to keep things organized:

### Homebrew Cleanup
After updating Homebrew, remove old versions of software to free up space:
```bash
brew cleanup
```
Example output:
```
Removing: /opt/homebrew/Cellar/git/2.40.0... (150 files, 45.2MB)
```

### Organize Your Downloads Folder
The `~/Downloads` folder often collects unnecessary files. Here’s what to do:
1. Open the **Downloads** folder in Finder.
2. Delete `.dmg` files (disk images) after installing apps.
3. Remove old installers, zip files, or anything you no longer need.
4. Move important files to proper folders like **Documents** or project-specific directories.

*(Tip: Your Dock includes a stack for quick access to Downloads!)*

### Empty the Trash
Files you delete aren’t gone until you empty the Trash:
1. Right-click (or Ctrl-click) the **Trash** icon in your Dock.
2. Select **Empty Trash**.

### Find Large Files
If you’re running out of space, find and delete large files:
1. Open Finder and press `Cmd + F` to start a search.
2. Click the **Kind** dropdown and select **Other...**.
3. Search for **File Size**, check the box, and click **OK**.
4. Set the search criteria to `File Size` | `is greater than` | `1` | `GB` (or `500 MB`).
5. Select **Search: This Mac** to find large files.

**Be careful not to delete system files!** If unsure, leave it alone.

*(Optional: Use a disk visualizer like GrandPerspective to see what’s taking up space: `brew install --cask grandperspective`.)*

---

## 3. Check Your Mac’s Performance 🩺

If your Mac feels slow, here’s how to troubleshoot:

### Use Activity Monitor
1. Open **Activity Monitor** (search for it using `Cmd + Space`).
2. Check the **% CPU** and **Memory** tabs.
3. Sort by usage to see which apps are using the most resources.
4. If an app is unresponsive, select it and click the **X** button to Force Quit. *(Save your work first if possible!)*

*(Advanced users can use the `htop` command in the terminal for more details: `sudo htop`.)*

### Restart Regularly
Restarting clears temporary memory and gives your Mac a fresh start. Aim to restart once a week:
1. Click the **Apple Menu ()**.
2. Select **Restart...**.

### Manage Login Items
Too many apps starting automatically can slow down your Mac:
1. Go to **System Settings > General > Login Items**.
2. Under **Open at Login**, remove apps you don’t need by selecting them and clicking the `-` (minus) button.

---

## 4. Back Up Your Mac with Time Machine 🛡️

Backing up your Mac is essential to protect your data. Here’s how to set up Time Machine:

1. **Get an External Drive:** Use a USB hard drive or SSD that’s at least 2-3 times the size of your Mac’s storage.
2. **Connect the Drive:** Plug it into your Mac.
3. **Enable Time Machine:**
   - macOS should ask if you want to use the drive for Time Machine. Click **Yes**.
   - If it doesn’t, go to **System Settings > General > Time Machine**, click **Add Backup Disk...**, and select your drive.
4. **Check Backups:** Look for the Time Machine icon in the menu bar (top-right). Click it to see the last backup time or choose **Back Up Now**.

---

## 5. Keep Docker in Check (If You Use Docker) 🐳

Docker can take up a lot of disk space over time. Clean up unused containers, images, and volumes with this command:
```bash
docker system prune
```
*(See the Docker guide for more details.)*

---

## 6. Bonus Tips for a Happy Mac 😊

### Keep Your Desktop Clean
A cluttered desktop can slow down your Mac. Move files into folders and keep only what you need visible.

### Use Spotlight for Quick Searches
Press `Cmd + Space` to open Spotlight and quickly find files, apps, or even perform calculations.

### Learn Keyboard Shortcuts
Shortcuts save time! Here are a few useful ones:
- `Cmd + Q`: Quit an app.
- `Cmd + W`: Close a window.
- `Cmd + Tab`: Switch between open apps.
- `Cmd + Shift + 4`: Take a screenshot of a selected area.

---

By following these simple steps, you’ll keep your Mac running smoothly and efficiently. A little maintenance goes a long way—happy housekeeping! 🧹✨
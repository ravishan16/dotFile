# Beginner's Guide: Git & GitHub Workflow 

Git is like a "time machine" for your projects. It saves snapshots (called **commits**) of your work, so you can go back to earlier versions or track changes. **GitHub** is an online platform where you can store these snapshots, share them, and collaborate with others.

This guide will walk you through the basics of using Git and GitHub step by step.

---

## Key Concepts

Here are the essential terms you need to know:

- **Repository (Repo):** A project folder tracked by Git. It contains your files and a hidden `.git` folder where Git stores the history.
- **Commit:** A saved snapshot of your project. You decide when to take a snapshot and add a message describing the changes.
- **Branch:** A separate line of work. Think of the `main` branch as the trunk of a tree. You can create branches (like limbs) to work on features without affecting the trunk.
- **Stage (Add):** Preparing specific changes for your next snapshot (commit). Think of it as putting items in a box before taking a photo.
- **Push:** Uploading your local snapshots (commits) to GitHub.
- **Pull:** Downloading updates from GitHub to your computer.
- **Remote:** A connection to a repo hosted online (e.g., GitHub). The default name is usually `origin`.

---

## Setting Up Git & GitHub

1. **Install Git:** Download and install Git from [git-scm.com](https://git-scm.com/).
2. **Configure Git:** Set your name and email (used in commits).
    ```bash
    git config --global user.name "Your Name"
    git config --global user.email "your.email@example.com"
    ```
3. **Set Up SSH Key:** This allows secure, password-free communication with GitHub.
    - Generate an SSH key:
        ```bash
        ssh-keygen -t ed25519 -C "your.email@example.com"
        ```
    - Copy the public key:
        ```bash
        cat ~/.ssh/id_ed25519.pub
        ```
    - Add it to GitHub: Go to **Settings > SSH and GPG keys > New SSH key**, paste the key, and save.

---

## Basic Git Workflow

Follow these steps to make changes to a project and upload them to GitHub:

1. **Navigate to Your Project:**
    ```bash
    cd ~/Projects/git/my-cool-project
    ```

2. **Check the Status:**
    ```bash
    git status
    ```
    *Example Output (if no changes):*
    ```
    On branch main
    nothing to commit, working tree clean
    ```

3. **Make Changes:** Edit a file (e.g., `README.md`) in your editor and save it.

4. **Check Status Again:**
    ```bash
    git status
    ```
    *Example Output (after editing):*
    ```
    Changes not staged for commit:
      modified: README.md
    ```

5. **Stage Your Changes:**
    ```bash
    git add README.md
    ```
    *To stage all changes:*
    ```bash
    git add .
    ```

6. **Commit Your Changes:**
    ```bash
    git commit -m "Update README with project details"
    ```

7. **Push to GitHub:**
    ```bash
    git push
    ```

8. **Pull Updates (if needed):**
    ```bash
    git pull
    ```

---

## Working with Branches

Branches let you work on new features without affecting the main project.

1. **Create & Switch to a New Branch:**
    ```bash
    git checkout -b new-feature
    ```

2. **Work & Commit:** Make changes, stage them (`git add .`), and commit (`git commit -m "Add feature"`).

3. **Switch Back to Main:**
    ```bash
    git checkout main
    ```

4. **Merge Your Branch:**
    ```bash
    git merge new-feature
    ```

5. **Push Changes:**
    ```bash
    git push
    ```

6. **Delete the Branch (Optional):**
    ```bash
    git branch -d new-feature
    git push origin --delete new-feature
    ```

---

## Tips for Success

- Use `git status` often to see what’s happening.
- Write clear commit messages to explain your changes.
- Always pull updates (`git pull`) before starting new work to avoid conflicts.

Git is a powerful tool, and this guide covers the basics to get you started. Happy coding!
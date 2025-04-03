# Docker User Guide: Cleaning Up Unused Resources 🐳🧹

Docker is a powerful tool for running applications in isolated "containers". However, over time, it can fill up your disk with unused files like old images, stopped containers, and more. This guide will show you how to clean up Docker safely and effectively.

---

## Why Clean Up Docker? 🗑️

When you use Docker, it creates and stores various resources. Over time, these can take up a lot of space:

1. **Stopped Containers:** Containers you ran but stopped still take up space.
2. **Dangling Images:** Images without tags or references, often leftover from builds.
3. **Unused Images:** Images not used by any container (running or stopped).
4. **Unused Volumes:** Persistent data storage created by containers you no longer use.
5. **Unused Networks:** Custom networks created for containers that no longer exist.
6. **Build Cache:** Temporary files created during image builds to speed up future builds.

---

## How to Clean Up Docker 💡

Docker provides simple commands to clean up unused resources. **Be careful**—some commands permanently delete data. Always double-check before running them.

### 1. Clean Everything Safely: `docker system prune`

This is the most common and safest cleanup command. It removes:
- Stopped containers
- Unused networks
- Dangling images
- Build cache

**Command:**
```bash
docker system prune
```

**Example:**
```bash
$ docker system prune
WARNING! This will remove:
  - all stopped containers
  - all networks not used by at least one container
  - all dangling images
  - all build cache

Are you sure you want to continue? [y/N] y
```

---

### 2. Aggressive Cleanup: `docker system prune -a`

This removes everything the standard prune does, **plus unused images** (images not used by any container). Use this only if you're okay with re-downloading images later.

**Command:**
```bash
docker system prune -a
```

**Example:**
```bash
$ docker system prune -a
WARNING! This will remove:
  - all stopped containers
  - all networks not used by at least one container
  - all dangling images
  - all unused images
  - all build cache

Are you sure you want to continue? [y/N] y
```

---

### 3. Clean Specific Resources

If you want to clean up only one type of resource, use these commands:

- **Stopped Containers:**
    ```bash
    docker container prune
    ```
    *(Example: Removes all stopped containers.)*

- **Dangling Images:**
    ```bash
    docker image prune
    ```
    *(Example: Removes images without tags or references.)*

- **Unused Volumes:** (**Be careful—this deletes data!**)
    ```bash
    docker volume prune
    ```
    *(Example: Removes volumes not attached to any container.)*

- **Unused Networks:**
    ```bash
    docker network prune
    ```
    *(Example: Removes networks not used by any container.)*

- **Build Cache:**
    ```bash
    docker builder prune
    ```
    *(Example: Removes temporary files from image builds.)*

---

## Check Disk Usage Before Cleaning 📊

Want to see how much space Docker is using before cleaning? Use this command:

**Command:**
```bash
docker system df
```

**Example:**
```bash
$ docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          10        3         5.2GB     3.1GB (60%)
Containers      5         1         1.2GB     1.0GB (83%)
Local Volumes   8         2         2.5GB     2.0GB (80%)
Build Cache     -         -         1.0GB     1.0GB
```

---

## Quick Tips for Beginners 📝

1. **Start with `docker system prune`:** It's the safest and easiest way to clean up.
2. **Use `docker system df` first:** Check what’s taking up space before deleting anything.
3. **Be cautious with `-a` and volume pruning:** These commands can delete data you might need later.
4. **Run cleanup regularly:** Keeping Docker tidy helps avoid running out of disk space.

Happy Docker-ing! 🐳✨
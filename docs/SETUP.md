# The Comprehensive Bootstrap Setup Guide

So, the `README.md` gave you the one-liner, but you're the curious type. You want to know what the `bootstrap.sh` script is *actually* doing to your pristine new Mac. Wise. Never trust a dolphin, and never run a script without knowing what's inside.

This guide will break it down for you.

## How It Works: The Orchestration

The magic is orchestrated by the main `./bootstrap.sh` script. It's not one giant, monolithic script, but a conductor that calls a series of smaller, more manageable "phase scripts" in a specific order. These phase scripts live in the `install/` directory.

Here are the phases of the journey:

*   **Phase 00: Preflight (`00_preflight.sh`)**
    This script is the pre-flight check for your spaceship. It makes sure you're on a compatible version of macOS, checks for an internet connection, and installs the absolute essentials: Xcode Command Line Tools, Homebrew, and Git.

*   **Phase 01: Packages (`01_packages.sh`)**
    This is the shopping spree. It takes your `Brewfile` and dutifully installs every single package, cask (application), and Mac App Store app on the list.

*   **Phase 02: Stow (`02_stow.sh`)**
    This script handles the symlinks. It first backs up any existing dotfiles in your home directory that might conflict, then uses `stow` to create symbolic links from this repository to your home directory (`~`).

*   **Phase 03: macOS Defaults (`03_macos.sh`)**
    This runs your `.macos` script, which should be filled with `defaults write` commands to tweak macOS to your liking. It's how you automate all those little system preference changes.

*   **Phase 04: Secrets (`04_secrets.sh`)**
    This phase deals with your sensitive data. It ensures you're logged into the 1Password CLI and then runs the "Butler" script (`scripts/generate-secrets.sh`) to create a local cache of your secrets. See `docs/SECRETS_WORKFLOW.md` for the full story.

*   **Phase 05: Application Setup (`05_apps.sh`)**
    Some applications need a little extra nudge after installation. This script handles app-specific configurations for things like iTerm2, Karabiner, and AeroSpace.

*   **Phase 06: Verification (`06_verify.sh`)**
    The final check. This script runs a series of tests to make sure everything installed correctly, symlinks are in place, and your system is ready to go.

## Running the Bootstrap

### Full Run

The standard procedure is simple:

```bash
cd ~/.dotfiles
./bootstrap.sh
```
This will execute all phases in order.

### Advanced Options

You have a couple of switches for more control:

*   **Dry Run:** See what the script *would* do without actually doing it.
    ```bash
    ./bootstrap.sh --dry-run
    ```

*   **Skip Phases:** Skip one or more phases by providing their numbers (comma-separated). This is useful if you want to re-run only a specific part of the setup.
    ```bash
    # Skip package installation (Phase 01)
    ./bootstrap.sh --skip-phases=01

    # Skip stow (02) and macOS defaults (03)
    ./bootstrap.sh --skip-phases=02,03
    ```

## Post-Install Manual Steps

The script is powerful, but it's not a sentient supercomputer. There are a few things you'll still need to do manually due to security or system limitations:

1.  **Sign in to GUI Apps**: You'll need to manually sign in to 1Password, Google Drive, Discord, Spotify, etc.
2.  **Grant System Permissions**: macOS will prompt you to grant accessibility and other permissions for apps like Karabiner-Elements, AeroSpace, Raycast, etc.
3.  **Run `p10k configure`**: If it's a fresh install, you may want to run this to configure your Zsh prompt style.

## Customization

This system is yours to modify. Here’s how:

*   **Apps & Tools**: Edit the `Brewfile` to add or remove packages, casks, and Mac App Store apps.
*   **macOS Settings**: Fill out the `~/.dotfiles/.macos` file with your desired `defaults write` commands.
*   **Secrets**: When you need to add a secret, follow the guide in `docs/SECRETS_WORKFLOW.md`.

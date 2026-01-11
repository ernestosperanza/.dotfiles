# .dotfiles - A Mostly Harmless Guide

**DON'T PANIC.**

You've stumbled upon a collection of dotfiles, a personal project that's grown into a sprawling, yet surprisingly organized, ecosystem for a Mac. This guide is your towel for navigating this particular corner of the galaxy.

### How to Bootstrap a New Mac (The Automated Way)

This repository is now a fully automated bootstrap system. On a new, shiny Mac, follow these crucial steps to kickstart your journey:

#### Step 0: Acquire Your Digital Towel (Install Command Line Tools)

Before you can even think about cloning this magnificent guide, you'll need `git`. And on a fresh Mac, `git` often plays hide-and-seek. Fear not! The `Xcode Command Line Tools` are your digital towel, providing `git` and other essential utilities for your terminal adventures.

Open your terminal and type this ancient incantation:
```bash
xcode-select --install
```
A mystical pop-up window will appear. Click "Install" and allow the cosmos (or Apple's servers) to deliver the necessary tools. This must be completed before you can proceed to the next, slightly less mystical, step.

#### Pre-flight Checklist: Log in to Apple ID for Mac App Store

To install applications directly from the Mac App Store (handled by `mas` via `brew bundle`), you must be logged into your Apple ID. This is an interactive process that cannot be automated by this script.

Open the App Store application (found in your Applications folder or via Spotlight, or by searching for "App Store") and log in with your Apple ID. Close the App Store app once logged in.

#### Step 1: Clone This Very Guide

With your digital towel in hand (and `git` at your command), it's time to fetch the map to navigate the maze.
```bash
git clone https://github.com/ernestosperanza/.dotfiles.git ~/.dotfiles
```

#### Step 2: Engage the Infinite Improbability Drive

Now for the grand finale! This single command will unleash a cascade of automation, installing all the latest tools (including an even fresher version of `git` via Homebrew, just for good measure) and meticulously configuring your system. Grab a cup of tea, a Pan Galactic Gargle Blaster, or just settle in – this might take a few minutes.
```bash
cd ~/.dotfiles && ./bootstrap.sh
```

That's it. The script will guide you through the rest. For a more detailed explanation of what's happening behind the scenes, consult the [**Comprehensive Setup Guide**](./docs/SETUP.md).

## What's In The Bag?

This setup comes with a few choice pieces of software, pre-configured for your convenience. The goal is a highly efficient, keyboard-driven environment, now set up automatically by our bootstrap system.

*   **A Souped-Up Shell (Zsh, Powerlevel10k, eza)**: The shell is your starship's cockpit. This setup uses Zsh, made beautiful and informative by Powerlevel10k, with `eza` as a modern replacement for `ls`.
*   **Neovim**: The editor of the gods, configured with `kickstart.nvim` as a solid foundation. It's ready to be extended with all the plugins your heart desires.
*   **Aerospace**: A tiling window manager for macOS that will make you feel like you're flying a spaceship.
*   **Karabiner-Elements**: For remapping your keyboard to do your bidding, a crucial component for a keyboard-centric workflow.
*   **Stow**: To manage all these dotfiles with clean symbolic links, keeping your home directory from looking like a Vogon construction site.
*   **And much more...** explore the `Brewfile` to see the full list of tools and applications.

## On Documentation

This guide is not exhaustive. There are other, more specific guides in the `docs/` directory:

*   [**Pro-Tips for the Discerning Hitchhiker**](./docs/tips.md): A collection of useful tips and tricks.
*   [**Future Explorations**](./docs/future-explorations.md): A list of interesting tools to check out later.
*   [**SSH with YubiKey**](./docs/ssh-yubikey.md): For the security-conscious.
*   [**The Bootstrap Setup Guide**](./docs/SETUP.md): A detailed look at how the bootstrap script works.
*   [**The Secrets Workflow**](./docs/SECRETS_WORKFLOW.md): How to handle API tokens and other secrets in the future.

So long, and thanks for all the fish!
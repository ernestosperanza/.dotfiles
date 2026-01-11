# .dotfiles - A Mostly Harmless Guide

**DON'T PANIC.**

You've stumbled upon a collection of dotfiles, a personal project that's grown into a sprawling, yet surprisingly organized, ecosystem for a Mac. This guide is your towel for navigating this particular corner of the galaxy.

### How to Bootstrap a New Mac (and not be sad)

So, you have a new, shiny Mac. It's beautiful, it's empty, and it's blissfully unaware of the chaos you're about to unleash upon it. Here's how to get it properly set up.

1.  **Install the Babel Fish of Compilers**: Apple's Command Line Tools are essential. Without them, you're just a frog trying to cross a busy intergalactic highway.
    ```bash
    xcode-select --install
    ```
2.  **Get the Universal Tool sharpener, Homebrew**: This is the tool that gets you the other tools.
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
    > **Note**: After installing, Homebrew might not be in your PATH. Run the following commands to add it, then restart your terminal.
    > ```bash
    > echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    > eval "$(/opt/homebrew/bin/brew shellenv)"
    > ```
3.  **Clone This Very Guide**: You need the map to navigate the maze. This command clones this repository into your home folder.
    ```bash
    git clone https://github.com/ernestosperanza/.dotfiles.git
    ```
4.  **Install Everything, All at Once**: Now for the magic. The `Brewfile` is your shopping list. This command installs everything on that list.
    ```bash
    brew bundle --file Brewfile
    ```
5.  **Put Everything in its Rightful Place**: `stow` is a clever little tool that creates symbolic links from this repository to your home directory. It's like having your cake and eating it too, but with config files.
    ```bash
    stow .
    ```

## What's In The Bag?

This setup comes with a few choice pieces of software, pre-configured for your convenience. The goal is a highly efficient, keyboard-driven environment.

*   **A Souped-Up Shell (Zsh, Powerlevel10k, eza)**: The shell is your starship's cockpit. This setup uses Zsh, made beautiful and informative by Powerlevel10k, with `eza` as a modern replacement for `ls`.
*   **Neovim**: The editor of the gods, configured with `kickstart.nvim` as a solid foundation. It's ready to be extended with all the plugins your heart desires.
*   **Aerospace**: A tiling window manager for macOS that will make you feel like you're flying a spaceship.
*   **Karabiner-Elements**: For remapping your keyboard to do your bidding, a crucial component for a keyboard-centric workflow.
*   **Stow**: To manage all these dotfiles with clean symbolic links, keeping your home directory from looking like a Vogon construction site.
*   **And much more...** explore the `Brewfile` to see the full list of tools and applications.

## Custom Scripts & Utilities

This repository contains scripts to automate common tasks, usually found in the `scripts/` directory.

### `scripts/setup_dock.sh` - The Infinite Improbability Dock

This script arranges your macOS Dock into a specific, predefined configuration. It's perfect for quickly restoring order to the chaotic universe of application icons.

*   **What it does**: It politely asks all current applications to leave the Dock, then invites a select few (like Safari, iTerm, etc.) to take their place in a neat line.
*   **How to Use**:
    ```bash
    # First, grant it the ability to do things (only needed once)
    chmod +x ~/.dotfiles/scripts/setup_dock.sh

    # Then, run it to rearrange the Dock to your liking
    ~/.dotfiles/scripts/setup_dock.sh
    ```
*   **Customization**: Feel free to edit the script to change the guest list. The list of applications is a simple array inside the file.

## On Documentation

This guide is not exhaustive. There are other, more specific guides in the `docs/` directory:

*   [**Pro-Tips for the Discerning Hitchhiker**](./docs/tips.md): A collection of useful tips and tricks.
*   [**Future Explorations**](./docs/future-explorations.md): A list of interesting tools to check out later.
*   [**SSH with YubiKey**](./docs/ssh-yubikey.md): For the security-conscious.

So long, and thanks for all the fish!

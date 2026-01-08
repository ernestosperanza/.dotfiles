# .dotfiles - A Mostly Harmless Guide

**DON'T PANIC.**

You've stumbled upon a collection of dotfiles, a personal project that's grown into a sprawling, yet surprisingly organized, ecosystem for a Mac. This guide is your towel for navigating this particular corner of the galaxy.

### How to Bootstrap a New Mac (The Automated Way)

This repository is now a fully automated bootstrap system. On a new, shiny Mac, just do the following:

1.  **Clone This Very Guide**: You need the map to navigate the maze.
    ```bash
    git clone https://github.com/ernestosperanza/.dotfiles.git ~/.dotfiles
    ```

2.  **Engage the Infinite Improbability Drive**: This one command will handle everything from installing tools to configuring your system. Grab a cup of tea, this might take a few minutes.
    ```bash
    cd ~/.dotfiles && ./bootstrap.sh
    ```

That's it. The script will guide you through the rest. For a more detailed explanation of what's happening, see the [**Comprehensive Setup Guide**](./docs/SETUP.md).

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
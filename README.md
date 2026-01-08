# .dotfiles - A Mostly Harmless Guide

**DON'T PANIC.**

You've stumbled upon a collection of dotfiles, a personal project that's grown into a sprawling, yet surprisingly organized, ecosystem for a Mac. This guide is your towel for navigating this particular corner of the galaxy.

## How to Bootstrap a New Mac (and not be sad)

So, you have a new, shiny Mac. It's beautiful, it's empty, and it's blissfully unaware of the chaos you're about to unleash upon it. Here's how to get it properly set up.

1.  **Install the Babel Fish of Compilers**: Apple's Command Line Tools are essential. Without them, you're just a frog trying to cross a busy intergalactic highway.
    ```bash
    xcode-select --install
    ```
2.  **Get the Universal Tool sharpener, Homebrew**: This is the tool that gets you the other tools.
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
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

This setup comes with a few choice pieces of software, pre-configured for your convenience:

*   **Zsh & Powerlevel10k**: A shell that's both powerful and pretty.
*   **Neovim**: The editor of the gods, or at least, of people who enjoy modal editing.
*   **Aerospace**: A tiling window manager for macOS that will make you feel like you're flying a spaceship.
*   **Karabiner-Elements**: For remapping your keyboard to do your bidding.
*   **And much more...** explore the `Brewfile` to see the full list.

## Pro-Tips for the Discerning Hitchhiker

### On Getting Things Done

Need to install the "Things 3" app? `mas` (Mac App Store) is your friend. It's already in your `Brewfile`.

1.  **Install Things 3**: You'll need its App Store ID, which is `904280696`. This only works if you've "purchased" it before. `mas` can't buy things for you, it's not your dad.
    ```bash
    mas install 904280696
    ```

### On Flying Your Spaceship (Aerospace)

Here are some tricks to make your Aerospace experience even more... spacious.

*   **Take a Screenshot**: This handy command lets you capture a portion of your screen to the clipboard.
    ```toml
    # In ~/.config/aerospace/aerospace.toml
    alt-shift-s = 'exec-and-forget screencapture -i -c'
    ```

*   **Take a Screenshot**: This handy command lets you capture a portion of your screen to the clipboard.
    ```toml
    # In ~/.config/aerospace/aerospace.toml
    alt-shift-s = 'exec-and-forget screencapture -i -c'
    ```

*   **Open a New Window**: Sometimes, `open -a Safari` doesn't do what you want. It just brings an existing window into focus. To force a new window, you need to speak to the machine in its native tongue: AppleScript.

    *   **Safari**:
        ```toml
        # In ~/.config/aerospace/aerospace.toml
        ctrl-g = '''exec-and-forget osascript -e '
        tell application "Safari"
            make new document at end of documents
            activate
        end tell'
        '''
        ```

    *   **Terminal**:
        ```toml
        # In ~/.config/aerospace/aerospace.toml
        ctrl-g = '''exec-and-forget osascript -e '
        tell application "Terminal"
            do script
            activate
        end tell'
        '''
        ```

*   **List Active Apps**: To see the `app-id` of active applications (useful for setting rules in your `aerospace.toml`), use:
    ```bash
    aerospace list-apps
    ```

## On Documentation

This guide is not exhaustive. There are other, more specific guides in the `docs/` directory:

*   [**Future Explorations**](./docs/future-explorations.md): A list of interesting tools to check out later.
*   [**Keyboard Manual**](./docs/keyboard.md): For the Mistel 770 BT keyboard.
*   [**SSH with YubiKey**](./docs/ssh-yubikey.md): For the security-conscious.
*   [**Outdated Docs**](./docs/Docs.md): An older doc with some shortcuts. It might be outdated, but it's here for historical purposes.

So long, and thanks for all the fish!
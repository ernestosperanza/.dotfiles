# Pro-Tips for the Discerning Hitchhiker

Here you will find a collection of loose tips, important info, and other tidbits that might make your journey through this digital galaxy a bit smoother.

## On Getting Things Done

Need to install the "Things 3" app? `mas` (Mac App Store) is your friend. It's already in your `Brewfile`.

1.  **Install Things 3**: You'll need its App Store ID, which is `904280696`. This only works if you've "purchased" it before. `mas` can't buy things for you, it's not your dad.
    ```bash
    mas install 904280696
    ```

## On Flying Your Spaceship (Aerospace)

Here are some tricks to make your Aerospace experience even more... spacious.

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

## Useful Brew Commands

Here are some handy `brew` commands to keep in your towel.

*   **List all installed apps**:
    ```bash
    brew list
    ```
*   **Create/update the `Brewfile` from your current setup**:
    ```bash
    cd ~/.dotfiles && brew bundle dump --force
    ```
*   **Install everything from the `Brewfile`**:
    ```bash
    brew bundle install
    ```

## Stow Your Gear

`stow` is the lovely bit of kit that keeps your home directory from looking like a Vogon construction site. It manages your config files by linking them from your `.dotfiles` directory to their proper homes.

*   **Put Everything in its Rightful Place**: To create all the symbolic links and deploy your configurations:
    ```bash
    # Run from the root of the .dotfiles repository
    stow .
    ```

*   **Disengage the Tractor Beam**: If you need to undo the linking, `stow` can clean up after itself. This removes the symlinks but leaves your precious source files in the repo untouched.
    ```bash
    # Run from the root of the .dotfiles repository
    stow -D .
    ```

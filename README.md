# .dotfiles

## Steps to bootstrap a new Mac

### Copy and paste this on the console

### Or run the steps manually

1. Install Apple's Command Line Tools, which are prerequisites for Git and Homebrew. `xcode-select --install`
2. Instal brew `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
3. Install git `brew install git`
4. Clone repo into home folder `git clone https://github.com/ernestosperanza/.dotfiles.git`
5. Install the bundle with brew `brew bundle --file Brewfile`
6. Simlink with `stow .` (just run it from this folder)

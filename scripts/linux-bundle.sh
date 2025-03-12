sudo apt install eza git neofetch neovim stow  zsh-autosuggestions zsh-syntax-highlighting 
sudo apt install alacritty doc-base snapd i3 spotify-client unzip curl virtualbox

sudo apt-get install i3-wm dunst i3lock i3status suckless-tools zsh
sudo apt-get install hsetroot xsel lxappearance scrot rofi 
sudo apt-get install cmus ranger compton
sudo apt-get install brave-browser

chsh -s $(which zsh)

# TODO: check if this is need it with the config
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
# echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

sudo snap install --classic code
sudo snap install --classic obsidian
sudo snap install postman ferdium zoom-client docker

# Install nerd font: TODO make a script
mkdir -p ~/.local/share/fonts/
cd ~/.local/share/fonts/
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.zip
fc-cache -fv
fc-list | grep "Meslo"


# Install rofi themes
# Clone this repository and change to its directory:
git clone https://github.com/lr-tech/rofi-themes-collection.git
cd rofi-themes-collection
# If you don't have the directories needed for the install create them with:
mkdir -p ~/.local/share/rofi/themes/
Copy your desired theme to ~/.local/share/rofi/themes folder:
cp themes/<your-selected-theme> ~/.local/share/rofi/themes/
# Run Rofi in run mode, then run rofi-theme-selector.

# Search for your desired theme, press enter to preview, then Alt+a to accept the new theme.
# Enjoy your new Rofi theme!
sudo apt install papirus-icon-theme



# Downlad wallpapers and config TODO
# move i3 config and i3status TODO
# move wallpapers TODO




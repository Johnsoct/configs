git pull

# TODO: convert into a loop via an array
# TODO: silent ln failures due to file already existing

# Symlinks
# Symlinks
# Symlinks

# NOTE: -f - remove existing destination files
# NOTE: -i - interactive prompt whether to remove destinations
# NOTE: -s - make symlinks instead of hard links

# Alacritty
ln -fs ~/dev/dotfiles/alacritty ~/.config

# Bash
ln -fs ~/dev/dotfiles/bash/.bashrc ~
ln -fs ~/dev/dotfiles/bash/.bash_aliases ~

# Fonts
ln -fs ~/dev/dotfiles/fontpatcher/DankMonoNerdFont-Regular.ttf ~/.local/share/fonts
ln -fs ~/dev/dotfiles/fontpatcher/DankMonoNerdFontPlusCodicons-Regular.ttf ~/.local/share/fonts

# FZF
ln -fs ~/dev/dotfiles/fzf/.fzf ~
ln -fs ~/dev/dotfiles/fzf/.fzf.bash ~

# # Nvim
ln -fs ~/dev/dotfiles/nvim ~/.config

# Vim
ln -fs ~/dev/dotfiles/vim/.vimrc ~

# Zellij
ln -fs ~/dev/dotfiles/zellij ~/.config

# Additional Installs
# Additional Installs
# Additional Installs
chmod +x ./node/global-packages.sh
./node/global-packages.sh

chmod +x ./cli/cli-tool-install.sh
./cli/cli-tool-install.sh

source ~/.bashrc

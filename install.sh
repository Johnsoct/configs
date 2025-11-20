git pull

# TODO: convert into a loop via an array
# TODO: silent ln failures due to file already existing

# Symlinks
# Symlinks
# Symlinks

# Alacritty
# BUG: when scripts runs, creates simlink also in ./alacritty
ln -s ~/dev/dotfiles/alacritty ~/.config/alacritty

# Bash
ln -s ~/dev/dotfiles/bash/.bashrc ~
ln -s ~/dev/dotfiles/bash/.bash_aliases ~

# Fonts
ln -s ~/dev/dotfiles/fontpatcher/DankMonoNerdFont-Regular.ttf ~/.local/share/fonts
ln -s ~/dev/dotfiles/fontpatcher/DankMonoNerdFontPlusCodicons-Regular.ttf ~/.local/share/fonts

# # Nvim
ln -s ~/dev/dotfiles/nvim ~/.config

# Vim
ln -s ~/dev/dotfiles/vim/.vimrc ~

# Zellij
ln -s ~/dev/dotfiles/zellij ~/.config

# Additional Installs
# Additional Installs
# Additional Installs
# ./node/global-packages.sh

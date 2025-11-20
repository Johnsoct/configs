# TODO: check for `uname -a` to determine whether linux distro
# is debian or fedora and install via apt/dnf
# EZA
git clone git@github.com:eza-community/eza.git
cd eza
cargo install --path .
cd ..
rm -rf eza

# Fastfetch
sudo dnf install fastfetch

# FD
sudo dnf install fd-find

# FZF
git clone git@github.com:junegunn/fzf.git
chmod +x fzf/install
./install
rm -rf fzf

# Lazygit
sudo dnf install lazygit

# Lua
curl -L -R -O https://www.lua.org/ftp/lua-5.1.5.tar.gz
tar zxf lua-5.1.5.tar.gz
cd lua-5.1.5
make linux
make test
sudo make install
cd ..
rm -rf lua-5.1.5.tar.gz
rm -rf lua-5.1.5

# Luarocks
git clone git@github.com:luarocks/luarocks.git
cd luarocks
chmod +x ./configure
./configure --with-lua-include=/usr/local/include
make
sudo make install
cd ..
rm -rf luarocks

# Image Magick
git clone --depth 1 --branch 7.1.2-0 git@github.com:ImageMagick/ImageMagick.git ImageMagick-7.1.2
cd ImageMagick-7.1.2
./configure
make
sudo make install
/usr/local/bin/magick logo: logo.gif
cd ..
rm -rf ImageMagick-7.1.2

# NVIM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Zioxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

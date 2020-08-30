#!/bin/bash

echo 'Installing packages'
sudo apt-get remove thunderbird
sudo apt-get update -qq && sudo apt-get install -qq seahorse thunderbird deluge deluged imwheel tmux xclip xcape ripgrep git fd-find emacs stow clang curl vim editorconfig markdown shellcheck

echo "Installing ruby dependencies"
sudo apt-get install -qq gawk g++ gcc autoconf automake bison libgdbm-dev libncurses5-dev libsqlite3-dev libtool libyaml-dev make sqlite3 zlib1g-dev libgmp-dev libreadline-dev libssl-dev

echo "Installing iosevka"
command -v wget && cd ~/Downloads && wget https://github.com/be5invis/Iosevka/releases/download/v3.0.0-rc.5/07-iosevka-curly-3.0.0-rc.5.zip
mkdir ~/.fonts
command -v unzip && unzip 07-iosevka-curly-3.0.0-rc.5.zip 'ttf/*' -d ~/.fonts/
cd ~/.fonts && mv ttf/* . && rm -rf ttf

echo "Installing dotfiles"
mkdir ~/Repositories && cd ~/Repositories
git clone https://github.com/vikdotdev/dotfiles
cd && mv .profile .profile.default && mv .bashrc .bashrc.default && mv .inputrc .inputrc.default
cd && ./Repositories/dotfiles/bin/bin/s-dotfiles-sync

echo "Installing doom"
cd && rm -r ~/.emacs
cd && git clone https://github.com/hlissner/doom-emacs ~/.emacs.d && ~/.emacs.d/bin/doom install

echo "Installing ruby and node"
\curl -sSL https://get.rvm.io | bash
\curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash

echo "Installing yarn"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update -qq && sudo apt-get install --qq yarn

source ~/.bashrc
nvm install --lts
rvm install ruby 2.6.5 && rvm use 2.6.5 --default

echo "Configuring tmux"
cd
rm -r ~/.tmux
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf

echo "Installing ruby gems"
gem install bundler
gem install tmuxinator

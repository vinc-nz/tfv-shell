#!/bin/bash
set -e

config_d=$(realpath $(dirname $0))
echo "config_d=$config_d"

echo "Installing packages"
if which -s apt-get; then
    sudo apt-get install -y fish vim tmux python3-venv xclip
    sudo ln -s /usr/bin/tmux /usr/local/bin
    sudo ln -s /usr/bin/fish /usr/local/bin
elif which -s brew; then
    brew install macvim tmux wget 
else
    echo "no known package manager found"
    echo "make sure vim,fish and tmux are installed and press a key to continue"
    read
fi

if ! fish -c 'omf version'; then
    echo "Installing omf"
	git clone https://github.com/oh-my-fish/oh-my-fish /tmp/omf
	/tmp/omf/bin/install --offline --noninteractive
fi

if ! fish -c 'omf theme bobthefish'; then
    echo "Installing shell theme"
    fish -c 'omf install bobthefish'
fi

echo "Creating symbolic links"

function create_symlink() {
    src=$1
    path=$2
    if [ -f $path ] && [ ! -L $path ]; then
        mv $path $path.bak
        echo "$path backed up as $path.bak"
    fi
    rm -rf $path
    ln -s $src $path
}

mkdir -p "$HOME/.config/fish"
create_symlink "${config_d}/config.fish" "$HOME/.config/fish/config.fish"
create_symlink "${config_d}/tmux.conf" "$HOME/.tmux.conf"
create_symlink "${config_d}/vimrc" "$HOME/.vimrc"
create_symlink "${config_d}/ftplugin" "$HOME/.vim/ftplugin"

if [ ! -d ~/.fzf ]; then
    echo "Installing fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
fi


echo "Installing vim plugins"
pip3 install --user --upgrade pynvim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c 'PlugInstall' -c qa

if which -s brew; then
    brew cask install font-saucecodepro-nerd-font
elif [ -d ~/.local ]; then
    echo "Installing font"
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts
    url='https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono.ttf'
    wget -qN $url
    fc-cache -fv .
fi

if which -s dconf; then
    echo "Installing gnome-terminal profile"
    uuid=fc220540-a8df-4718-afb0-2c4111d2f7b8
    profile_key_path=/org/gnome/terminal/legacy/profiles:/:$uuid/
    profile_list_key=/org/gnome/terminal/legacy/profiles:/list
    dconf load $profile_key_path < "${config_d}/gnome-terminal-profile.dconf"
    profile_list=$(dconf read $profile_list_key)
    if [[ "$profile_list" != *"$uuid"* ]]; then
        dconf write $profile_list_key "${profile_list/]/, \'$uuid\']}"
    fi
elif [ -d ~/Library/Application\ Support/iTerm2/ ]; then
    echo "installing iTerm2 profile"
    mkdir -p ~/Library/Application\ Support/iTerm2/DynamicProfiles
    ln -s "${config_d}/tfv-shell-iterm2-profile-osx.json" ~/Library/Application\ Support/iTerm2/DynamicProfiles
else
    echo "no known terminal app found"
    echo "to start set a new terminal with powerline nerd fonts and run"
    echo
    echo "  /usr/local/bin/tmux"
    echo
    echo "for fonts see https://github.com/ryanoasis/nerd-fonts"
    exit 0
fi

echo "=================="
echo "     ALL DONE     "
echo "=================="

echo "Run a new terminal with profile tfv-shell to start"

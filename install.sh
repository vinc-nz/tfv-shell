#!/bin/bash
set -e

config_d=$(realpath $(dirname $0))
echo "config_d=$config_d"

echo "Installing packages"
if which -s apt-get; then
    sudo apt-get install -y fish vim tmux python3-venv xclip
    sudo ln -s /usr/bin/tmux /usr/local/bin
elif which -s brew; then
    brew install macvim tmux wget 
else
    echo "no known package manager found. aborting"
    exit 1
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

echo "Installing vim plugins"
mkdir -p ~/.vim/pack/tfv-shell/start
cd ~/.vim/pack/tfv-shell/start
set +e
git clone https://github.com/vim-airline/vim-airline.git
git clone https://github.com/vim-airline/vim-airline-themes
git clone https://github.com/ctrlpvim/ctrlp.vim
git clone https://github.com/907th/vim-auto-save.git
git clone https://github.com/vim-syntastic/syntastic.git
git clone https://github.com/janko/vim-test
git clone https://github.com/vimwiki/vimwiki.git
git clone https://github.com/fatih/vim-go.git
git clone https://github.com/SirVer/ultisnips.git
git clone https://github.com/vim-python/python-syntax.git
git clone --recursive https://github.com/davidhalter/jedi-vim.git
mkdir -p black/plugin
cd black/plugin
wget -qN https://raw.githubusercontent.com/psf/black/19.10b0/plugin/black.vim
if ! vim -E -c BlackVersion -c q; then
    echo "WARNING: black does not seem to work, removing the plugin"
    rm *
fi    
cd
set -e

if [ -d ~/.local ]; then
    echo "Installing font"
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts
    url='https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono.ttf'
    wget -qN $url
    fc-cache -fv .
elif which -s brew; then
    brew cask install font-saucecodepro-nerd-font
fi

if which dconf &> /dev/null; then
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
    ln -s "${conf_d}/tfv-shell-iterm2-profile-osx.json" ~/Library/Application\ Support/iTerm2/DynamicProfiles
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

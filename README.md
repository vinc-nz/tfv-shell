# tfv-shell

Setup your shell with

* [tmux](https://github.com/tmux/tmux)
* [fish](https://fishshell.com/)
* [vim](https://www.vim.org/)
* [source code pro nerd font](https://github.com/ryanoasis/nerd-fonts)

## Installation

Clone the repo and run

    ./install.sh

For Mac users this requires iTerm2 and brew, for Linux users this requires `apt-get` and gnome-terminal

the script will setup a new terminal profile called `tfv-shell`. 

Run a new terminal with the tf-shell profile and you are ready to go.

## Customization

### terminal

* white on black background
* [source code pro nerd font](https://github.com/ryanoasis/nerd-fonts)
* runs `tmux` on start 

### fish shell

* vi keys
* includes [omf](https://github.com/oh-my-fish/oh-my-fish)
* [bob-the-fish](https://github.com/oh-my-fish/theme-bobthefish) theme
* automatically renames tmux windows based on currect directory

### tmux

* fish as shell
* large scrollback buffer size
* prefix set to C-a (like screen)
* theme generated by [tmuxline.vim](https://github.com/edkolev/tmuxline.vim) to match vim theme
* yanks to system clipboard

### vim

Comes with plugins

* [airline](https://github.com/vim-airline/vim-airline)
* [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim)
* [autosave](https://github.com/907th/vim-auto-save)
* [syntastic](https://github.com/vim-syntastic/syntastic)
* [vim-test](https://github.com/janko/vim-test)
* [vimwiki](https://github.com/vimwiki/vimwiki)
* [ultisnips](https://github.com/SirVer/ultisnips)
* python development plugins
    - [python-syntax](https://github.com/vim-python/python-syntax)
    - [jedi-vim](https://github.com/davidhalter/jedi-vim)
    - [black](https://github.com/psf/black/blob/master/plugin/black.vim)
* go development plugins
    - [vim-go](https://github.com/fatih/vim-go)

and moreover you can paste in insert mode without setting paste mode ;)

## Cheatsheet

### tmux

`C-a r` reload configuration
 
`C-a n` new window

`C-a w` choose window

`C-a 1..9` move to window
 
`C-h` previous-window

`C-l` next-window

`C-b` last used window
 
`C-a v` split window vertically

`C-a o` split window horizontally
 
`C-a j,k,h,l` move cursor across panes
 
`C-a +` resize pane down 

`C-a -` resize pane up

`C-a <` resize pane left

`C-a >` resize pane right
 
`C-[` enter copy mode

`C-]` paste

### tmux (copy mode)

`h,j,k,l` (or arrow keys) move cursor

`w` move to next word

`b` move to previous word

`Space`  start selection

`V` select whole line under cursor

`Enter` exit copy mode

### vim

```o`` open file (activates ctrlp plugin, which is not actually mapped to ctrl+p)

```p`` go to last used buffer

```h`` go to previous buffer

```l`` go to next buffer

```x`` delete buffer

see vimrc for more shortcuts


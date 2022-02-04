# shell config
set -g theme_nerd_fonts yes
fish_vi_key_bindings
bind -M insert \ce forward-word forward-char
bind -M insert \cw nextd-or-forward-word
bind -M insert \cp history-search-backward
bind -M insert \cn history-search-forward

# env variables
set -gx EDITOR vim

# aliases
alias wiki="vim -c VimwikiIndex"

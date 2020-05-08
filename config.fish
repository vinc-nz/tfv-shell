# shell config
set -g theme_nerd_fonts yes
fish_vi_key_bindings
bind -M insert \ce forward-word forward-char
bind -M insert \cw nextd-or-forward-word
bind -M insert \cp history-search-backward
bind -M insert \cn history-search-forward

# env variables
set -gx PIPENV_VENV_IN_PROJECT true
set -gx EDITOR vim

# aliases
alias wiki="vim -c VimwikiIndex"

# tmux setup
if set -q TMUX
    function rename_tmux_pane --on-variable PWD
        tmux rename-window (basename (pwd))
    end
    rename_tmux_pane 
    if command -sq xclip
        tmux bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -sel clip"
    end
end


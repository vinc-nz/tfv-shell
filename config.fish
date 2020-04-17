# shell config
set -g theme_nerd_fonts yes

# env variables
set -gx PIPENV_VENV_IN_PROJECT true

# aliases
alias wiki="vim -c VimwikiIndex"

# tmux setup
if set -q TMUX
    function rename_tmux_pane --on-variable PWD
        tmux rename-window (basename (pwd))
    end
    rename_tmux_pane
end


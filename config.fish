set -gx theme_nerd_fonts yes

set -gx PIPENV_VENV_IN_PROJECT true
#function vimtags --on-variable VIRTUAL_ENV
#   ctags -R -f .vimtags
#end

function rename_tmux_pane --on-variable PWD
   tmux rename-window (basename (pwd))
end

alias wiki="vim -c VimwikiIndex"

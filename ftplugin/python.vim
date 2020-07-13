let g:python_highlight_all = 1
call deoplete#custom#option('sources', {
\ '_': ['ale'],
\})
let g:ale_fixers = ['black']
let b:ale_linters = ['flake8', 'pyls']
" let g:ale_python_pyls_executable = '/usr/local/bin/pyls-language-server'
" let g:ale_python_flake_executable = '/usr/local/bin/flake8-3'
let g:ale_fix_on_save = 1

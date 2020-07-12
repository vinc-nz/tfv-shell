let g:python_highlight_all = 1
call deoplete#custom#option('sources', {
\ '_': ['ale'],
\})
let g:ale_fixers = ['black']
let b:ale_linters = ['flake8', 'pyls']
" let g:ale_python_flake8_executable = '/usr/local/bin/flake8'
" let g:ale_python_pyls_executable = '/usr/local/bin/pyls-language-server'
let g:ale_fix_on_save = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:airline#extensions#ale#enabled = 1
nmap <Leader>f :ALEFix<cr>
nmap <Leader>r :ALERename<cr>
nmap <C-]> :ALEGoToDefinition<cr>
nmap <Leader>? :ALEHover<cr>
nmap <Leader>* :ALEFindReferences<cr>
nmap <Leader>2 :TestFile<cr>

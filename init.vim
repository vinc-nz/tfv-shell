lua require "vinc.plugins"
lua require "vinc.telescope"
lua require "vinc.statusline"
lua require "vinc.autosave"
lua require "vinc.lsp"
lua require "vinc.tabline".setup({})

set noswapfile
set ignorecase
set number
set expandtab
set updatetime=1000
set tabstop=4
set shiftwidth=4
set completeopt=menuone,noinsert,noselect
set shortmess+=c

let g:startify_change_to_dir = 0

augroup custom_term
    autocmd!
    " keep the terminal open when the command has terminated
    autocmd TermOpen * setlocal bufhidden=hide buflisted
    autocmd TermOpen,TermEnter * setlocal nonumber
    " autocmd BufLeave term://* let @t = bufnr("%")
augroup END

" auto-open quickfix
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

hi CursorLine cterm=NONE ctermbg=235
set cursorline
augroup cursor_hi
    autocmd!
    autocmd WinLeave * set nocursorline 
    autocmd WinEnter * set cursorline 
augroup END

command! -bang -nargs=* Te call RunInSplitTerm(<q-args>)
function! RunInSplitTerm(cmd)
    execute 'split | terminal ' . a:cmd
    let b:cmd = a:cmd
    wincmd J
endfunction

command! -bang -nargs=1 -complete=dir Tab call NewTab(<q-args>)
function NewTab(path)
    let path = a:path
    let head = fnamemodify(path, ":p:h")
    tabnew path
    execute 'tcd '.head
    lua require('vinc.telescope').find_files()
endfunction


" set the prefix (=leader) for custom commands
let mapleader = "`"

"   delete buffer
nnoremap <Leader>x :bd<cr>

"   turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

"   resize panel vertically to 80 chars
nnoremap \| <C-W>80\|

nmap <leader>w viW<space>

"   search for visually selected text
vnoremap <space> y/\V<C-R>=escape(@",'/\')<CR><CR>

" Use word under cursor as search pattern
nnoremap <space> m`:keepjumps normal! *``<cr>

"   exit insert mode
inoremap <C-c> <Esc>

" quickfix navigation
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>

" Telescope
nnoremap <leader>* <cmd>lua require('telescope.builtin').lsp_references()<CR>
nnoremap <leader>d <cmd>lua require('telescope.builtin').lsp_definitions()<CR>
nnoremap <leader>, <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>
nnoremap <leader>/ <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>
nnoremap <leader>b <cmd>lua require('telescope.builtin').file_browser()<CR>
nnoremap <leader>p <cmd>lua require('telescope.builtin').registers()<CR>
nnoremap <leader>m <cmd>lua require('telescope.builtin').marks()<CR>
nnoremap <C-k> <cmd>lua require('telescope.builtin').buffers{only_cwd = true}<CR>
nnoremap <C-p> <cmd>lua require('telescope.builtin').commands()<CR>
nnoremap <leader>o <cmd>lua require('vinc.telescope').find_files()<CR>
nnoremap <leader>s <cmd>lua require('vinc.telescope').grep_hl()<CR>

" lsp
nnoremap [e <cmd>lua vim.lsp.diagnostic.goto_prev()<CR> 
nnoremap ]e <cmd>lua vim.lsp.diagnostic.goto_next()<CR> 
nnoremap <leader>a <cmd>lua vim.lsp.buf.code_action()<CR> 
nnoremap <C-]> <cmd>lua vim.lsp.buf.definition()<CR> 
nnoremap <leader>h <cmd>lua vim.lsp.buf.hover()<CR> 
nnoremap <leader>r <cmd>lua vim.lsp.buf.rename()<CR> 
augroup lsp
    autocmd!
    autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics{focusable = false}
    autocmd CursorHold * lua vim.lsp.buf.formatting()
augroup END

" signify
nmap ]h <plug>(signify-next-hunk)
nmap [h <plug>(signify-prev-hunk)
nmap <leader>i <plug>(signify-hunk-diff)
nmap <leader>u <plug>(signify-hunk-undo)

" copy filename to clipper
nnoremap <Leader>n :silent exec '!echo '.expand('%:p').' \| nc localhost 8377'<CR>

" exit terminal mode
tnoremap <esc> <C-\><C-n>
tnoremap <C-r> <cmd>exec 'terminal '.b:cmd<cr>

"tabs
autocmd TabLeave * let @b = bufnr('%')
command! Blt execute 'b'.getreg('b')
nnoremap <C-n> <cmd>tabn<cr>
nnoremap <C-p> <cmd>tabp<cr>
nnoremap <C-Space> g<Tab><CR>

"meta
set path+=~/fbcode

lua require "fb.telescope"

let g:python3_host_prog = '/home/vinc/venv/bin/python3'
let g:clang_format#command = "/usr/local/bin/clang-format"

augroup fb
    autocmd!
    au BufEnter TARGETS set filetype=bzl
    au BufEnter *.cconf,*.cinc,*.ctest,*.tw set filetype=python
augroup END

command! -bang Fbgs lua require('fb.telescope').biggrep_search{cmd = "fbgs", cwd = '~/fbcode'}
command! -bang Fbgf lua require('fb.telescope').biggrep_search{cmd = "fbgf", cwd = '~/fbcode'}
command! -bang Cbgs lua require('fb.telescope').biggrep_search{cmd = "cbgs", cwd = '~/configerator'}
command! -bang Cbgf lua require('fb.telescope').biggrep_search{cmd = "cbgf", cwd = '~/configerator'}
command! -bang -nargs=1 Rg call GrepString(<q-args>)
function! GrepString(search)
    v:lua.biggrep_search(search)
endfunction
function! BigGrep(word, cmd, local_path)
    let search = a:word
    let cmd = a:cmd
    let cwd = a:local_path
    lua require('fb.telescope').biggrep_search{cmd = cmd, cwd = cwd}
endfunction

function! JFInlinesToLL()
  let cmd = 'jf inlines | grep fbcode'
  lcd ~/fbsource
  cexpr system(cmd)
  lcd -
endfunction

command! -bang DiffComments call JFInlinesToLL()
command! -bang Pastry echo system('pastry', @0)

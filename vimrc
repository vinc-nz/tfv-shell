""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Loosely based on
"   https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
" automatically save any changes made to buffers before they're hidden
set autowriteall

" enable syntx highlighting
syntax on
" drop compatibility as it might cause troubles with some plugins
set nocompatible

" do not write backup files
set nobackup


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" show commands being typed in the last line of the screen
set showcmd
" show line numbers
set number
" set background colour
set background=dark

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" visual autocomplete for command menu
set wildmenu            


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Keybindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" good to know predefined keys
"
" move between windows in split mode
"   ctrl+w hjkl
" search for word under cursor
"   *
" start visual mode and select the next match
"   gn
" delete next match and start insert mode
"   cgn
" visual mode (block)
"   ctrl+v
" visual mode (line)
"   shift+v

" set the prefix (=leader) for custom commands
let mapleader = "`"

"   move one paragraph up
nnoremap <c-up> {
"   move one paragraph down
nnoremap <c-down> }

"   copy to system clipboard
noremap <Leader>y "+y
noremap <Leader>d "+d
"   copy all to system keyboard
noremap <Leader>a gg"+yG

"   move to next buffer
nnoremap <Leader>l :bn<cr>

"   move to previous buffer
nnoremap <Leader>h :bp<cr>

"   move to last used buffer
nnoremap <Leader>p :b#<cr>

"   delete buffer
nnoremap <Leader>x :bd<cr>

"   turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

"   go back after a tag jump
nmap <leader>[ <C-T>

"   cycle throgh windows
nnoremap <space> <C-W>w
"   resize panel vertically to 80 chars
nnoremap \| <C-W>80\|

"   go to highlighted location in quickfix list
nnoremap <Leader>n :cc<cr>
"   go to highlighted location in location list
nnoremap <Leader>m :ll<cr>
"   close quickfix and location list
nnoremap <Leader>c :lclose \| cclose<cr>

"   search for visually selected text
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>
" hint: once the text is highlighted you can just replace it with
"   %s//<your-replacement-string>

"   exit insert mode
inoremap <C-c> <Esc>

"   auto close pairs
inoremap " ""<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use two spaces instead of 4 for yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2

" automatically open quickfix window when using :vimgrep
"  :cn go to next occurrence
"  :cdo run command for each occurrence
"  :cclose close quickfix window
"  for more info :help quickfix 
augroup qf
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    cwindow
    autocmd VimEnter        *     cwindow
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General plugins configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ctrlp_map = '<Leader>o'

let g:auto_save = 1
let g:auto_save_events = ["InsertLeave", "CursorHold"]
let g:auto_save_silent = 1  " do not display the auto-save notification

let g:airline_theme='deus'
let g:airline_powerline_fonts=1
let g:airline_section_warning = '%{SyntasticStatuslineFlag()}'
let g:airline_section_c = '%{getcwd()}'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '

let g:vimwiki_list = [{'path': '~/Dropbox/wiki/', 'syntax': 'markdown', 'ext': '.txt'}]
nmap <Leader>i <Plug>VimwikiIndex
nmap <Leader>t <Plug>VimwikiMakeDiaryNote

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
        \ "mode": "active",
        \ "passive_filetypes": ["python", "go"] }

let test#strategy = "make"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Python plugins configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python_highlight_all = 1

let g:jedi#goto_command = "<leader>]"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_stubs_command = "<leader>s"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

let g:vimpy_prompt_resolve = 1

function! PythonBuild()
    Black
    write
    SyntasticCheck
endfunction
autocmd FileType python let g:auto_save_postsave_hook = 'call PythonBuild()'
autocmd FileType python nmap <Leader>1 :call PythonBuild()<cr>
autocmd FileType python nmap <Leader>2 :TestFile<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => go plugins configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
autocmd FileType go nmap <leader>1  <Plug>(go-build)
autocmd FileType go nmap <leader>2  <Plug>(go-test)
autocmd FileType go nmap <leader>3  <Plug>(go-run)
autocmd FileType go nmap <leader>r  <Plug>(go-rename)
autocmd FileType go nmap <leader>]  <Plug>(go-def)

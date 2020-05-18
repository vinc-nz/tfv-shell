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

hi CursorLine cterm=NONE ctermbg=235
set cursorline
augroup cursor_hi
    autocmd!
    autocmd WinLeave * set nocursorline 
    autocmd WinEnter * set cursorline 
augroup END

" so that backspace behaves like you would expect to
set backspace=indent,eol,start

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

"   resize panel vertically to 80 chars
nnoremap \| <C-W>80\|

"   go to highlighted location in quickfix list
nnoremap <Leader>n :cc<cr>
"   close quickfix and location list
nnoremap <Leader>c :lclose \| cclose<cr>

"   search for visually selected text
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>
" hint: once the text is highlighted you can just replace it with
"   %s//<your-replacement-string>

"   exit insert mode
inoremap <C-c> <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General plugins configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.fzf
nmap <Leader>o :Files<cr>
nmap <Leader>b :Buffers<cr>

let g:auto_save = 1
let g:auto_save_events = ["InsertLeave", "CursorHold"]
let g:auto_save_silent = 1  " do not display the auto-save notification

let g:airline_theme='deus'
let g:airline_powerline_fonts=1
let g:airline_section_c = '%{getcwd()}'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '

let g:ale_fixers = {'python': ['black']}
let g:ale_completion_enabled = 1
let b:ale_linters = {'python': ['flake8']}
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:airline#extensions#ale#enabled = 1
nmap <Leader>f :ALEFix<cr>
nmap <Leader>r :ALERename<cr>
nmap <Leader>] :ALEGoToDefinition<cr>
nmap <Leader>? :ALEHover<cr>
nmap <Leader>* :ALEFindReferences<cr>

let g:vimwiki_list = [{'path': '~/Dropbox/wiki/', 'syntax': 'markdown', 'ext': '.txt'}]
nmap <Leader>i <Plug>VimwikiIndex
nmap <Leader>t <Plug>VimwikiMakeDiaryNote

let test#strategy = "make"

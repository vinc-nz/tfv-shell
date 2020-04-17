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
nnoremap <Leader>w :bd<cr>

"   move to next item in location list
nnoremap <Leader>n :lnext<cr>

"   turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

"   search for visually selected text
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>

"   exit insert mode
inoremap <C-c> <Esc>

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
let g:auto_save_in_insert_mode = 0

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Python plugins configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python_highlight_all = 1

let g:jedi#goto_command = "<leader>b"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_stubs_command = "<leader>s"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

autocmd FileType python let g:auto_save_postsave_hook = 'silent! SyntasticCheck'
autocmd FileType python nmap <Leader>f :Black<cr>


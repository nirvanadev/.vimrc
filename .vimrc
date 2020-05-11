"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"
"
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.

set nocompatible

" ================ General Config ====================

set number relativenumber       "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set noerrorbells                "No sounds
set novisualbell                "No flashing
set autoread                    "Reload files changed outside vim
set encoding=utf-8
set ttimeout
set ttimeoutlen=0
set hlsearch
set showmatch


" Enable autocompletion:
set wildmode=longest,list,full

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader=" "

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

" Shortcutting split navigation, saving a keypress:
" the following few are old mappings from before I embraced hjkl which is why
" they are commente out.
"map <Leader><left> <C-w>h
"map <Leader><right> <C-w>l
"map <Leader><up> <C-w>k
"map <Leader><down> <C-w>j

"Switch panes easier. Old. Before tmux/iterm
" map <Leader>h <C-w>h
" map <Leader>j <C-w>j
" map <Leader>k <C-w>k
" map <Leader>l <C-w>l

map <Leader>h :exe "noh" <CR>

" Orgmode mappings
map <Leader>oa <Plug>OrgNewHeadingAboveNormal
map <Leader>ob <Plug>OrgNewHeadingBelowNormal
map <Leader>c <Plug>OrgCheckBoxToggle

" Quicker switch to previous buffer
map <Leader>n :exe "bn" <CR>

" Close current buffer quicker
map <Leader>q :exe "bwipeout" <CR>

" Close current buffer and return to previous
map <F7> :exe "b#" <CR> <bar> :exe "bwipeout#" <CR>
map <Leader>x :exe "b#" <CR> <bar> :exe "bwipeout#" <CR>

" This will execute the current line in bash silently
map <Leader>e :exe "silent .w !bash" <CR>

" Toggle GOYO
map <Leader>d :Goyo \| set linebreak <CR>

" FZF
map <Leader>f :Files <CR>
map <Leader>b :Buffers <CR>

" Quickly switch between php and html syntax
map <Leader>s :call PHPToggle()<CR>
" Function to check the filetype and switch accordingly
function! PHPToggle()
    if &ft == "php"
        set ft=html
    elseif &ft == "html"
        set ft=php
    endif
endfunction

" Quick Command Prompt
map <Leader><Leader> :

" Quick Emmet Wrap
map <leader><cr> <c-y>,

" Easily adjust splits
nnoremap <silent> = 10<C-w>>
nnoremap <silent> - 10<C-w><
nnoremap <silent> _ 10<C-w>-
nnoremap <silent> + 10<C-w>+

" The following F2, F3 commands save and open a session
map <F2> :mksession! ~/.vim_session <cr>
map <F3> :source ~/.vim_session <cr>

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
" vnoremap <C-c> "+y
" map <C-p> "+P
set clipboard=unnamed

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Go Back to last cursor position
nmap <C-B> <C-O>

" Save as sudo and load file back in
map <Leader>w :silent w !sudo tee %

" ================ Indentation ======================

set autoindent
set copyindent
set incsearch
set nosmarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set noexpandtab

filetype plugin indent on

" Display tabs and trailing spaces visually

set wrap       "Wrap lines
set linebreak  "Wrap lines at convenient points

"Mode Settings

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)

"Cursor settings:

"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

execute pathogen#infect()

" =============== Plugin Specific ==================
"
" https://vimawesome.com/plugin/nerdtree-red
map <Leader>o :NERDTreeToggle<CR>
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \     'left': [ [ 'mode', 'paste' ],
      \               [ 'readonly', 'filename', 'modified', 'myname' ] ]
      \ },
      \ 'component': {
      \     'myname': 'K33F'
      \ }
      \ }
set noshowmode

" https://github.com/plasticboy/vim-markdown

" let g:vimwiki_list = [{'path': '~/notes/', 'path_html': '~/notes_html/',
"                        \ 'index': 'index', 'ext': '.md'}]
" let g:vimwiki_folding = 'list'
"

let g:php_syntax_extensions_enabled = ["php"]
let g:PHP_outdentphpescape = 0

autocmd BufWritePost ~/notes/*.md call WriteNotes2Server()
function WriteNotes2Server()
    :Vimwiki2HTML
    :!rsync -ru -e 'ssh -p 7822' ~/notes_html/* nirvananotes@notes.nirvanasites.com:~/public_html/
    :redraw!
endfunction

set rtp+=/usr/local/opt/fzf

autocmd FileType php setlocal indentkeys-==<?
autocmd FileType php setlocal indentkeys-==?>

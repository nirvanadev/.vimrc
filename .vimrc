"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"
"
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.


" ================ General Config ====================
set nocompatible
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
set mouse=nicr
set viminfo='100,f1

set t_ut=""

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

" Set 256 Color Mode
set t_Co=256

" Remove highlight on searches
map <Leader>0 :exe "noh" <CR>

" NERDTree
map <Leader>no :NERDTreeToggle<CR>
map <Leader>ni :NERDTreeFind<CR>

" Orgmode mappings
nmap <C-j> <localleader>hh
imap <C-j> <Esc><localleader>hh
nmap <C-k> <localleader>hN
imap <C-k> <Esc><localleader>hN
nmap <Leader>c <localleader>cc


" Move lines like a boss
nnoremap <localleader>j :m .+1<CR>==
nnoremap <localleader>k :m .-2<CR>==
inoremap <localleader>j <Esc>:m .+1<CR>==gi
inoremap <localleader>k <Esc>:m .-2<CR>==gi
vnoremap <localleader>j :m '>+1<CR>gv=gv
vnoremap <localleader>k :m '<-2<CR>gv=gv

" map <Leader>ok <localleader>hN
" map <Leader>oj <Plug>OrgNewHeadingBelowNormal
" Quick saving
map <F1> :w<CR><Esc>
imap <F1> <c-o><F1>

" Find Visually selected text with //
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Split jumping
nnoremap <Leader>wl <C-W><C-L>
nnoremap <Leader>wh <C-W><C-H>
nnoremap <Leader>wk <C-W><C-K>
nnoremap <Leader>wj <C-W><C-J>

" Function to create bookmarks (marks)
function! SetGMark(mark, filename, line_nr)
    let l:mybuf = bufnr(a:filename, 1)
    call setpos("'".a:mark, [l:mybuf, a:line_nr, 1, 0])
endf
" Set the various marks to load common files like a champ
call SetGMark('L', '/mnt/d/ownCloud/hd1/orgnotes/work/compulse/log.org', 5)
call SetGMark('T', '/mnt/d/ownCloud/hd1/orgnotes/work/compulse/tasks.org', 3)
call SetGMark('V', '/home/k33f/.vimrc', 58)
call SetGMark('A', '/mnt/d/ahk_scripts/ahk_2020/ahk33.ahk', 6)

" Quick Tab/Buffer Movements
map <Leader>j :bn <CR>
map <Leader>k :bp <CR>
map <Leader>l :tabnext <CR>
map <Leader>h :tabprev <CR>
map <Leader>x :bd <CR>

" Quicker scrolling
nnoremap <PageUp> <S-{>
nnoremap <PageDown> <S-}>

" This will execute the current line in bash silently
map <Leader>e :exe "silent .w !bash" <CR>

" Toggle GOYO
" map <Leader>d :Goyo \| set linebreak <CR>

" FZF
map <Leader>f :Files <CR>
map <Leader>b :Buffers <CR>

" Quickly switch between php and html syntax
map <Leader>t :call PHPToggle()<CR>
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

" The following commands save and open a session
nnoremap <Leader>ss :mksession! ~/vim-sessions/
nnoremap <Leader>so :source ~/vim-sessions/

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
" vnoremap <C-c> "+y
" map <C-p> "+P
set clipboard=unnamedplus

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Go Back to last cursor position
nmap <C-B> <C-O>

" Save as sudo and load file back in
map <Leader>w :silent w !sudo tee %

" Escape from insert mode when two j's or k's are pressed (because what word has 2
" friggin j's or k's?)
imap hh <ESC>l
imap jj <ESC>j
imap kk <ESC>k

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
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'ayu_dark',
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

" let g:php_syntax_extensions_enabled = ["php"]
" let g:PHP_outdentphpescape = 0

let g:org_indent = 1

" set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf

" autocmd FileType php setlocal indentkeys-==<?
" autocmd FileType php setlocal indentkeys-==?>

" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")

let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
	augroup WSLYank
	  autocmd!
	  autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
	augroup END
endif

set termguicolors     " enable true colors support
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

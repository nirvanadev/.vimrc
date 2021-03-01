"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"
"
" ================ Init ==============================
let g:ale_disable_lsp = 1
let g:airline#extensions#ale#enabled = 1

" ================ Plugins ===========================
call plug#begin("~/.vim/plugged")
	" Formatting
	Plug 'tpope/vim-surround'
	Plug 'mattn/emmet-vim'
	Plug '2072/PHP-Indenting-for-VIm'
	" Theme
	Plug 'dracula/vim', { 'as': 'dracula' }
	Plug 'ryanoasis/vim-devicons'
	Plug 'morhetz/gruvbox'
	" File Tree
	Plug 'scrooloose/nerdtree'
	" Status Bar
	Plug 'vim-airline/vim-airline'
	" File Searching
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	" Intellisense
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-phpls', 'coc-python', 'coc-diagnostic', 'coc-fzf-preview']
	Plug 'dense-analysis/ale'
	Plug 'sheerun/vim-polyglot'
	" Splash Screen
	Plug 'mhinz/vim-startify'
	" Notes
	Plug 'elzr/vim-json'
	Plug 'plasticboy/vim-markdown'
	Plug 'vim-pandoc/vim-pandoc-syntax'
	Plug 'jceb/vim-orgmode'
	Plug 'tpope/vim-speeddating'
call plug#end()

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
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle the tree
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" Orgmode
let g:org_indent = 1
let g:org_heading_highlight_colors = ['Title', 'Constant', 'Statement',
    \   'Type', 'DraculaYellow', 'DraculaOrange']
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
" nnoremap <A-h> <C-w>h
" nnoremap <A-j> <C-w>j
" nnoremap <A-k> <C-w>k
" nnoremap <A-l> <C-w>l
nnoremap <Esc>h <C-w>h
nnoremap <Esc>j <C-w>j
nnoremap <Esc>k <C-w>k
nnoremap <Esc>l <C-w>l

" FUNCTION TO CREATE BOOKMARKS (MARKS)
function! SetGMark(mark, filename, line_nr)
    let l:mybuf = bufnr(a:filename, 1)
    call setpos("'".a:mark, [l:mybuf, a:line_nr, 1, 0])
endf
" SET THE VARIOUS MARKS TO LOAD COMMON FILES LIKE A CHAMP
call SetGMark('L', '/c/Users/k33f/ownCloud/hd1/orgnotes/work/compulse/log.org', 6)
call SetGMark('T', '/c/Users/k33f/ownCloud/hd1/orgnotes/work/compulse/tasks.org', 3)
call SetGMark('V', '/home/k33f/.vimrc', 58)
call SetGMark('A', '/d/ahk_scripts/ahk_2020/ahk33.ahk', 6)

" QUICK TAB/BUFFER MOVEMENTS
map <Leader>j :bn <CR>
map <Leader>k :bp <CR>
map <Leader>l :tabnext <CR>
map <Leader>h :tabprev <CR>
map <Leader>x :bd <CR>

" QUICKER SCROLLING
nnoremap <PageUp> <S-{>
nnoremap <PageDown> <S-}>

" THIS WILL EXECUTE THE CURRENT LINE IN BASH SILENTLY
map <Leader>e :exe "silent .w !bash" <CR>

" FZF
set rtp+=~/.fzf
map <Leader>f :Files <CR>
map <Leader>b :Buffers <CR>

" QUICK COMMAND PROMPT
map <Leader><Leader> :

" QUICK EMMET WRAP
map <leader><cr> <c-y>,

" EASILY ADJUST SPLITS
nnoremap <silent> = 10<C-w>>
nnoremap <silent> - 10<C-w><
nnoremap <silent> _ 10<C-w>-
nnoremap <silent> + 10<C-w>+

" SESSIONS
nnoremap <Leader>ss :mksession! ~/vim-sessions/
nnoremap <Leader>so :source ~/vim-sessions/

" VIM CLIPBOARD
set clipboard=unnamedplus

" SAVE AS SUDO
map <Leader>w :silent w !sudo tee %

" INDENTATION
set autoindent
set copyindent
set incsearch
set nosmarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set noexpandtab
filetype plugin indent on

" WRAPPING
set wrap       "Wrap lines
set linebreak  "Wrap lines at convenient points

" CURSOR MODES
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)

" CURSOR REFERENCE
"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

" AIRLINE
set laststatus=2

" WIN 10 CLIPBOARD
let s:clip = '/c/Windows/System32/clip.exe'
if executable(s:clip)
	augroup WSLYank
	  autocmd!
	  autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
	augroup END
endif

" THEME CONFIG
set termguicolors
let g:dracula_colorterm = 0
syntax enable
colorscheme dracula

" STARTIFY CONFIG
let g:ascii_header = [
	\ ' _    __________  __ ',
	\ '| | _|___ /___ / / _|',
	\ '| |/ / |_ \ |_ \| |_ ',
	\ '|   < ___) |__) |  _|',
	\ '|_|\_\____/____/|_|  ',
	\ ''
	\ ]                     
let g:startify_custom_header =
	\ startify#pad(g:ascii_header + startify#fortune#boxed())

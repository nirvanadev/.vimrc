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

map <Leader>h <C-w>h
map <Leader>j <C-w>j
map <Leader>k <C-w>k
map <Leader>l <C-w>l

" Quicker switch to previous buffer
map <Leader>b <C-^>

" Close current buffer and return to previous
map <F7> :exe "b#" <CR> <bar> :exe "bwipeout#" <CR>

" This will execute the current line in bash silently
map <Leader>e :exe "silent .w !bash" <CR>

" toggle goyo - marginalized views
map <Leader>f :Goyo \| set linebreak<CR>

" Easily adjust splits
nnoremap <silent> = 10<C-w>>
nnoremap <silent> - 10<C-w><
nnoremap <silent> _ 10<C-w>-
nnoremap <silent> + 10<C-w>+

" The following F2, F3 commands save and open a session
map <F2> :mksession! ~/.vim_session <cr>
map <F3> :source ~/.vim_session <cr>

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
vnoremap <C-c> "+y
map <C-p> "+P

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

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
      \ }
set noshowmode

" https://github.com/plasticboy/vim-markdown

let g:vimwiki_list = [{'path': '~/notes/', 'path_html': '~/notes_html/',
                       \ 'index': 'index', 'ext': '.md'}]
" let g:vimwiki_folding = 'list'

autocmd BufWritePost ~/notes/*.md call WriteNotes2Server()
function WriteNotes2Server()
    :Vimwiki2HTML
    :!rsync -ru -e 'ssh -p 7822' ~/notes_html/* nirvananotes@notes.nirvanasites.com:~/public_html/
    :redraw!
endfunction

set background=dark
colorscheme solarized
set nocompatible
set fileformats=unix,mac,dos
set vb t_vb= " no beep sound
set backspace=indent,eol,start
"" Leader
"let mapleader=","
" Path
let path = "~/code/dotfiles"
set nrformats-=octal " treat octal and hexadecimal number as decimal number
if has("mouse")
    set mouse=a
endif

"-----------------------------------------------------
" short cut keys
"-----------------------------------------------------
" Jump to vimrc
nnoremap <space><space> :<C-u>edit $MYVIMRC<CR>
" Reload vimrc setting
nnoremap <space>s :<C-u>source $MYVIMRC<CR>

"-----------------------------------------------------
" Backup
"-----------------------------------------------------
set nobackup
if !filewritable($HOME."/.vim-backup")
    call mkdir($HOME."/.vim-backup", "p")
endif
set backupdir=$HOME/.vim-backup
if !filewritable($HOME."/.vim-swap")
    call mkdir($HOME."/.vim-swap", "p")
endif
set directory=$HOME/.vim-swap
"let &directory = &backup dir
set writebackup

"-----------------------------------------------------
" Search
"-----------------------------------------------------
set history=100
set ignorecase
set smartcase
set wrapscan
set incsearch

"-----------------------------------------------------
" Display
"-----------------------------------------------------
syntax on
set title
set nonumber
set ruler
set showcmd
set laststatus=2
set showmatch
set matchtime=3
set hlsearch
"highlight WhitespaceEOL ctermbg=red guibg=red
"matc WhitespaceEOL /\s\+$/
highlight Comment ctermfg=DarkCyan
set wildmenu
set whichwrap=b,s,h,l,<,>,[,]
set textwidth=0
" Show zenkaku space
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
matc ZenkakuSpace /　/
"
set statusline=%n\:%y%F\ %{fugitive#statusline()}\|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=%c\:%l/%L\|%P\|
highlight StatusLine term=NONE cterm=NONE ctermfg=black ctermbg=white
set cursorline
set ruler
set nostartofline
set virtualedit=block
set scrolloff=5
set sidescroll=10

"-----------------------------------------------------
" Window
"-----------------------------------------------------
"imap <C-w> <C-o><C-w>

"-----------------------------------------------------
" Template
"-----------------------------------------------------
"autocmd BufNewFile *.html 0r ~/code/dotfiles/template/skeleton.html
"autocmd BufNewFile *.py   0r ~/code/dotfiles/template/skeleton.py

"-----------------------------------------------------
" Tab
"-----------------------------------------------------
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround

"-----------------------------------------------------
" Indent
"-----------------------------------------------------
set autoindent
set smartindent

"----------------------------------------------------
" Character encoding
"----------------------------------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8

"----------------------------------------------------
" vim-tab
"----------------------------------------------------
cmap tnew :tabnew<space>
nnoremap <silent> <C-l> :<C-u>tabnext<CR>
nnoremap <silent> <C-h> :<C-u>tabprevious<CR>

set clipboard=unnamed


source ~/.vimrc.plugin

if filereadable(expand('~/.vimrc.mine'))
    source ~/.vimrc.mine
endif

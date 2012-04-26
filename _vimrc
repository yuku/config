"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"                                 _                                             "
"                          _   __(_)___ ___  __________                         "
"                         | | / / / __ `__ \/ ___/ ___/                         "
"                         | |/ / / / / / / / /  / /__                           "
"                         |___/_/_/ /_/ /_/_/   \___/                           "
"                                                                               "
"                                                                               "
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

"-----------------------------------------------------
" Anonymous
"-----------------------------------------------------
syntax on
" solarized - http://ethanschoonover.com/solarized
colorscheme solarized
set background=dark

"colorscheme molokai
"colorscheme desert

" No beep sound
set vb t_vb=

" Treat octal and hexadecimal number as decimal number
" octal  Numbers that start with a zero will be considered to be octal
"        Example: Using CTRL-A on "007" results in "010"
" hex    Numbers starting with "0x" or "0X" will be considered to be hexadecimal
"        Example: Using CTRL-X on "0x100" results in "0x0ff"
set nrformats-=octal,hex

" Print the line number in front of each line
set nonumber

" Enable the use of the mouse in all modes
if has("mouse")
    set mouse=a
endif
" Enable all keys to move the cursor left/right to the previous/next line
set whichwrap=b,s,h,l,<,>,[,]

"-----------------------------------------------------
" short cut keys
"-----------------------------------------------------
" Jump to vimrc
nnoremap <space><space> :<C-u>edit $DOTFILES/_vimrc<CR>
" Reload vimrc setting
nnoremap <space>s :<C-u>source $DOTFILES/_vimrc<CR>

"-----------------------------------------------------
" Backup
"-----------------------------------------------------
" backup current file, deleted afterwards
set nobackup
set writebackup
if !filewritable($HOME."/.vim-backup")
    call mkdir($HOME."/.vim-backup", "p")
endif
set backupdir=$HOME/.vim-backup
if !filewritable($HOME."/.vim-swap")
    call mkdir($HOME."/.vim-swap", "p")
endif
set directory=$HOME/.vim-swap
"let &directory = &backup dir

"-----------------------------------------------------
" Search
"-----------------------------------------------------
" keep 100 lines of command line histories
set history=100
set ignorecase
set smartcase
" Searches wrap around the end of the file
set wrapscan
" While typing a search command, show where the pattern matches
set incsearch
" highlighting matches
set hlsearch
" turn off highlight by Esc x 2
nmap <ESC><ESC> :nohlsearch<CR><ESC>

"-----------------------------------------------------
" Display
"-----------------------------------------------------
set title
" Show the line and column number of the cursor position, separated by a comma
set ruler
" Show (partial) command in the last line of the screen
set showcmd
" The last window always have status line
set laststatus=2
" When a bracket is inserted, briefly jump to the matching one
set showmatch
" 3 second to show the matching paren
set matchtime=3
" highlight whitespaces
highlight WhitespaceEOL ctermbg=red guibg=red
matc WhitespaceEOL /\s\+$/
" highlight comments
highlight Comment ctermfg=DarkCyan
" Use enhanced command-line completion
set wildmenu
" Never break so long line
set textwidth=0
set wrapmargin=0
" Keep position of the cursor
set nostartofline
" Cursor can be positioned where there is no actual character in Visual block mode.
set virtualedit=block
" Keep at least 5 lines above and below the cursor
set scrolloff=5
set sidescroll=10
" highlight cursor line in current window
set cursorline
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END
highlight clear CursorLine
highlight CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black


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
" Use utf-8
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8
" Automatic end-of-file format detection
set fileformats=unix,mac,dos

"----------------------------------------------------
" vim-tab
"----------------------------------------------------
cnoremap <C-t> <C-u>tabnew<CR>
nnoremap <silent> <C-l> :<C-u>tabnext<CR>
nnoremap <silent> <C-h> :<C-u>tabprevious<CR>

set clipboard=unnamed

" Leader
let mapleader='\'

source ~/.vimrc.plugin

au BufRead,BufNewFile Gemfile set filetype=ruby
au BufRead,BufNewFile *.json set filetype=javascript

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

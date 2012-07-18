"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
"                                _                                          "
"                         _   __(_)___ ___  __________                      "
"                        | | / / / __ `__ \/ ___/ ___/                      "
"                        | |/ / / / / / / / /  / /__                        "
"                        |___/_/_/ /_/ /_/_/   \___/                        "
"                                                                           "
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

"" General

set nocompatible            " use Vim in more useful way
"set clipboard+=unnamed     " share clipboard with other systems

"" Text Formatting

set autoindent              " automatic indent new lines
set smartindent             " be smart about it
inoremap # X<BS>#
set wrap                    " wrap lines
set sidescroll=5
set softtabstop=2
set shiftwidth=2
set shiftround
set tabstop=4
set expandtab               " expand tabs to spaces
set nosmarttab              " fuck tabs
set formatoptions+=n        " support for numbered/bullet lists
set wrapmargin=0
set virtualedit=block       " allow virtual edit in visual block ..

set textwidth=79            " wrap at 79 chars by default
if v:version >= 703
  set colorcolumn=+1
endif


"" Remapping

let mapleader=','           " Lead with ,
" Jump to vimrc
nnoremap <space><space> :<C-u>edit $HOME/.vimrc<CR>
" Reload vimrc setting
nnoremap <space>s       :<C-u>source $HOME/.vimrc<CR>
" Create new tab
cnoremap <C-t> <C-u>tabnew<CR>
nnoremap <C-h> :<C-u>tabprevious<CR>
nnoremap <C-l> :<C-u>tabnext<CR>

"" UI

set ruler                   " show the cursor position all the time
" highlight cursor line in current window
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END
highlight clear CursorLine
highlight CursorLine ctermbg=black
"
set showcmd                 " display incomplete commands
set number                  " line numbers
set nolazyredraw            " don't redraw while executing macros
set wildmenu                " turn on wild menu
set wildmode=list:longest,full
set cmdheight=1             " command line height
" Enable all keys to move the cursor left/right to the previous/next line
set whichwrap=b,s,h,l,<,>,[,]
" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
set shortmess=filtoOA       " shorten messages
set report=0                " tell us about changes
set nostartofline           " don't jump to the start of line when scrolling
set showmatch               " brackets/braces that is
set matchtime=3             " duration to show matching brace (1/10 sec)
set laststatus=2            " The last window always have status line
set scrolloff=5             " Keep at least 5 lines above and below the cursor
set visualbell t_vb=        " No beep sound
" Treat octal and hexadecimal number as decimal number
" octal  Numbers that start with a zero will be considered to be octal
"        Example: Using CTRL-A on "007" results in "010"
" hex    Numbers starting with "0x" or "0X" will be considered to be hexadecimal
"        Example: Using CTRL-X on "0x100" results in "0x0ff"
set nrformats-=octal,hex
if has("mouse") " Enable the use of the mouse in all modes
  set mouse=a
endif

syntax on
"" Colorize

" Keep this order!
" solarized - http://ethanschoonover.com/solarized
colorscheme solarized
set background=dark

" highlight whitespaces
highlight WhitespaceEOL ctermbg=red
matc WhitespaceEOL /\s\+$/

" highlight comments
"highlight Comment ctermfg=DarkCyan

"" Backup

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

"" Search

set history=100             " keep 100 lines of command line histories
set ignorecase
set smartcase
set wrapscan                " Searches wrap around the end of the file
" While typing a search command, show where the pattern matches
set incsearch
set hlsearch                " highlighting matches
" turn off highlight by Esc x 2
nmap <ESC><ESC> :nohlsearch<CR><ESC>

"" Character encoding

set encoding=utf-8          " Use utf-8
set termencoding=utf-8      " ..
set fileencodings=utf-8     " ..
" Automatic end-of-file format detection
set fileformats=unix,mac,dos


"" Source
autocmd BufRead,BufNewFile Capfile,Gemfile set filetype=ruby
autocmd BufRead,BufNewFile *.json          set filetype=javascript
autocmd BufRead,BufNewFile *.md            set filetype=markdown
autocmd BufRead,BufNewFile *.psgi          set filetype=perl

if filereadable(expand('~/.vimrc.plugins'))
  source ~/.vimrc.plugins
endif
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" vim: set filetype=vim :

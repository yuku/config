set nocompatible            " use Vim in more useful way
set clipboard+=unnamed      " share clipboard with other systems
set helplang=ja,en          " search ja help docs if exists

inoremap # X<BS>#
set shiftround
set virtualedit=block       " allow virtual edit in visual block ..
set ambiwidth=double
set autoread                " prevent W11 warning
set visualbell t_vb=        " No beep sound
set nolazyredraw            " don't redraw while executing macros
set report=0                " tell us about changes

set encoding=utf-8          " Use utf-8
set termencoding=utf-8      " ..
set fileencodings=utf-8     " ..
" Automatic end-of-file format detection
set fileformats=unix,mac,dos

" backup current file, deleted afterwards
set backup
set writebackup
if !filewritable($HOME."/.vim-backup")
  call mkdir($HOME."/.vim-backup", "p")
endif
set backupdir=$HOME/.vim-backup
if !filewritable($HOME."/.vim-swap")
  call mkdir($HOME."/.vim-swap", "p")
endif
set directory=$HOME/.vim-swap

"" Persistent undo
if has('persistent_undo')
    set undodir=~/.vim/undo
    set undofile
endif

if !has('gui')
    augroup Redraw
        au!
        au WinEnter,BufRead,FocusGained * redraw!
    augroup END
endif

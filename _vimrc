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
set number
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
autocmd BufNewFile *.html 0r ~/code/dotfiles/template/skeleton.html
autocmd BufNewFile *.py   0r ~/code/dotfiles/template/skeleton.py

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

"-----------------------------------------------------
" Plugins
"-----------------------------------------------------
filetype off
set rtp+=~/.vim/vundle.git/
call vundle#rc()

" YankRing
Bundle 'YankRing.vim'
nnoremap <silent>;ys  :<C-u>YRShow<CR>
let g:yankring_history_file='.yankring_history'

" fugitive
Bundle 'fugitive.vim'

" unite.vim
Bundle 'unite.vim'
"let g:unite_enable_split_vertically = 1
let g:unite_winwidth = 50
nnoremap [unite] <Nop>
nmap <space>u [unite]
nnoremap <silent> [unite]u :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]c :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru<CR>
nnoremap <silent> [unite]i :<C-u>Unite -buffer-name=files buffer<CR>
nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=files bookmark<CR>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap [unite]s :<C-u>Unite source<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
    " Overwrite settings
    nmap <buffer><ESC>  <Plug>(unite_exit)
    nmap <buffer><C-c>  <Plug>(unite_exit)
    imap <buffer>jj     <Plug>(unite_insert_leave)
    imap <buffer><C-w>  <Plug>(unite_delete_backward_path)

    " <C-l>: manual neocomplecache completion.
    inoremap <buffer><C-l>  <C-x><C-u><C-p><Down>

    " Start insert.
    let g:unite_enable_start_insert = 1

    nmap <buffer><expr><C-k>  unite#do_action('split')
    imap <buffer><expr><C-k>  unite#do_action('split')
    nmap <buffer><expr><C-i>  unite#do_action('vsplit')
    imap <buffer><expr><C-i>  unite#do_action('vsplit')
endfunction"}}}

" surround
Bundle 'surround.vim'
let g:surround_{char2nr("#")} = "{# \r #}"
let g:surround_{char2nr("*")} = "/* \r */"
let g:surround_{char2nr("p")} = "<?php \r ?>"

" quick run
Bundle 'quickrun.vim'
nmap <Leader>r <plug>(quickrun)

" NERD Tree
"Bundle 'The-NERD-Tree'
"let NERDChristmasTree = 1
"let NERDTreeAutoCenterThreshold = 5
"let NERDTreeShowHidden = 1

" taglist.vim
Bundle 'taglist.vim'

" neocomplcache
Bundle 'neocomplcache'
let g:neocomplcache_enable_at_startup = 1

filetype plugin indent on

" VimShell
nnoremap [vimshell] <Nop>
nmap <space>v [vimshell]
nnoremap <silent> [vimshell]v :<C-u>VimShell<CR>
nnoremap <silent> [vimshell]py :<C-u>VimShellInteractive ipython<CR>
nnoremap <silent> [vimshell]rb :<C-u>VimShellInteractive irb<CR>
vmap <silent> [vimshell]s :<C-u>VimShellSendString<CR>

"-----------------------------------------------------
" Code Cleaning 
"-----------------------------------------------------
if !exists("rtrim")
    function! RTrim()
        let s:cursor = getpos(".")
        %s/\s\+$//e
        call setpos(".", s:cursor)
    endfunction
    
    autocmd BufWritePre *.{py,java,rb,js,php,pl,js,html,css,rhtml,yml} call RTrim()
endif

"-----------------------------------------------------
" local settings
"-----------------------------------------------------
if filereadable(expand('~/.vimrc.mine'))
    source ~/.vimrc.mine
endif

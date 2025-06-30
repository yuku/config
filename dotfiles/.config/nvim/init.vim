" General
set nocompatible             " Use Vim in more useful way
filetype on                  " Enable filetype detection
filetype indent on           " Enable filetype-specific indenting
filetype plugin on           " Enable filetype-specific plugins
set clipboard+=unnamed       " share clipboard with other systems
set helplang=ja,en           " search ja help docs if exists
set virtualedit=block        " allow virtual edit in visual block ..
set autoread                 " prevent W11 warning
set visualbell t_vb=         " No beep sound
set nolazyredraw             " don't redraw while executing macros
set report=0                 " tell us about changes
set encoding=utf-8           " Use utf-8
set fileencodings=utf-8      " ..
set fileformats=unix,mac,dos " Automatic end-of-file format detection

if !has('nvim')
  set termencoding=utf-8     " ..
endif

set number                   " line numbers
set showcmd                  " display incomplete commands
set ruler                    " show the cursor position all the time
set foldmethod=marker
set clipboard+=unnamed       " share clipboard with other systems

" Behavior
set autoindent              " automatic indent new lines
set smartindent             " be smart about it
set wrap                    " wrap lines
set softtabstop=2
set shiftwidth=2
set expandtab               " expand tabs to spaces
set nosmarttab              " fuck tabs
set formatoptions+=n        " support for numbered/bullet lists
set tabstop=8
set wrapmargin=0
set textwidth=99            " wrap at 99 chars by default
" Enable all keys to move the cursor left/right to the previous/next line
set whichwrap=b,s,h,l,<,>,[,]
" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
set nostartofline           " don't jump to the start of line when scrolling
set wildmenu                " turn on wild menu
set wildmode=list:longest,full
set completeopt=menu,menuone

set colorcolumn=125
execute "set colorcolumn=" . join(range(126, 999), ',')

let mapleader=','            " Lead with ,

nnoremap <C-h> :<C-u>tabprevious<CR>
nnoremap <C-l> :<C-u>tabnext<CR>
" Recall command-line from history, whose beginning matches the current command-line.
cnoremap <C-p> <UP>
cnoremap <C-n> <DOWN>
" Expand %% as %:h
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" turn off highlight by Esc x 2
nmap <ESC><ESC> :<C-u>nohlsearch<CR><ESC>

set listchars=tab:▸\ ,eol:¬

" highlight cursor line in current window
augroup cch
    autocmd!
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END
highlight clear CursorLine
highlight CursorLine ctermbg=black

" Key mappings
" Jump to init.vim
nnoremap <space>v :<C-u>edit $CONFIG_ROOT/config/nvim/init.vim<CR>
" Reload init.vim setting
nnoremap <space>s :<C-u>source $HOME/.config/nvim/init.vim<CR>

" Teach a Vim to fish
if &shell =~# 'fish$'
  set shell=sh
endif

" Plugins
" Automatic installation
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
Plug 'dag/vim-fish'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': './install --bin' } | Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-user' | Plug 'rhysd/vim-textobj-ruby', { 'for': 'ruby' }
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

" Add plugins to &runtimepath
call plug#end()

" base16
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" fzf
let g:fzf_action = {
                      \ 'ctrl-t': 'tab split',
                      \ 'ctrl-i': 'vsplit',
                      \ 'ctrl-k': 'split' }
nnoremap <C-p> :<C-u>GFiles<CR>
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

" vim-airline
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

set statusline=%{LinterStatus()}

let g:airline_theme='base16'

" vim-easymotion

" Disable default mapping
let g:EasyMotion_do_mapping = 0

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
vmap s <Plug>(easymotion-bd-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" vim-fugitive
nnoremap <silent>gs :<C-u>Gstatus<CR>

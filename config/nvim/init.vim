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
set termencoding=utf-8       " ..
set fileencodings=utf-8      " ..
set fileformats=unix,mac,dos " Automatic end-of-file format detection

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
nnoremap <space>v :<C-u>edit $DOTFILES_ROOT/config/nvim/init.vim<CR>
" Reload init.vim setting
nnoremap <space>s :<C-u>source $HOME/.config/nvim/init.vim<CR>

" {{{1 health check
"" Python 2 provider
let s:python_executable=$HOME.'/.pyenv/versions/neovim2/bin/python'
if executable(s:python_executable)
  let g:python_host_prog=s:python_executable
else
  echoe 'g:python_host_prog is not set. Make neovim2 virtualenv with neovim package'
endif

"" Python 3 provider
let s:python3_executable=$HOME.'/.pyenv/versions/neovim3/bin/python'
if executable(s:python3_executable)
  let g:python3_host_prog=s:python3_executable
else
  echoe 'g:python3_host_prog is not set. Make neovim3 virtualenv with neovim package'
endif

" {{{1 Plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'flowtype/vim-flow', { 'for': 'javascript' }
Plug 'junegunn/fzf', { 'do': './install --bin' } | Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-user' | Plug 'rhysd/vim-textobj-ruby', { 'for': 'ruby' }
Plug 'noprompt/vim-yardoc', { 'for': 'ruby' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' } | Plug 'maxmellon/vim-jsx-pretty', { 'for': 'javascript' }
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'w0rp/ale'
Plug 'wokalski/autocomplete-flow'

" Add plugins to &runtimepath
call plug#end()

" {{{2 deoplate.nvim
let g:deoplete#enable_at_startup = 1

" {{{2 base16
let base16colorspace=256
colorscheme base16-default-dark

" {{{2 fzf
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

" {{{2 vim-airline

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

" {{{2 vim-easymotion

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

" {{{2 vim-flow
let g:flow#autoclose = 1
let g:flow#enable = 1
let g:flow#timeout = 4

" {{{2 vim-fugitive
nnoremap <silent>gs :<C-u>Gstatus<CR>

" {{{2 vim-go
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"

" We take care to preserve the user's fileencodings and fileformats,
" because those settings are global (not buffer local), yet we want
" to override them for loading Go files, which are defined to be UTF-8.
let s:current_fileformats = ''
let s:current_fileencodings = ''

" define fileencodings to open as utf-8 encoding even if it's ascii.
function! s:gofiletype_pre()
  let s:current_fileformats = &g:fileformats
  let s:current_fileencodings = &g:fileencodings
  set fileencodings=utf-8 fileformats=unix
  setlocal filetype=go
endfunction

" restore fileencodings as others
function! s:gofiletype_post()
  let &g:fileformats = s:current_fileformats
  let &g:fileencodings = s:current_fileencodings
endfunction

augroup MyGolangConfig
    au!
    au BufNewFile *.go setlocal filetype=go fileencoding=utf-8 fileformat=unix
    au BufRead *.go call s:gofiletype_pre()
    au BufReadPost *.go call s:gofiletype_post()
augroup END

" {{{2 vim-javascript
let g:javascript_plugin_flow = 1

" {{{2 vim-json
let g:vim_json_syntax_conceal = 0

" {{{2 vim-plug
augroup MyVimPlugSettings
    autocmd!
    autocmd FileType vim-plug setlocal nonumber
augroup END

" {{{2 ale
let g:ale_linters = {
      \   'javascript': ['eslint'],
      \   'ruby': ['rubocop'],
      \ }
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %severity%: %s'
let g:ale_lint_on_text_changed = 'never'

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

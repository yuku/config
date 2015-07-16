"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
"                                _                                          "
"                         _   __(_)___ ___  __________                      "
"                        | | / / / __ `__ \/ ___/ ___/                      "
"                        | |/ / / / / / / / /  / /__                        "
"                        |___/_/_/ /_/ /_/_/   \___/                        "
"                                                                           "
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

" ------------------------------
" Plugins {{{
" ------------------------------
if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

filetype off
filetype plugin indent off
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', { 'build': {
                \ 'windows' : 'make -f make_wingw32.mak',
                \ 'cygwin'  : 'make -f make_cygwin.mak',
                \ 'mac'     : 'make -f make_mac.mak',
                \ 'unix'    : 'make -f make_unix.mak'
            \ } }

" Autocomplete
NeoBundle 'Shougo/neocomplete.vim'

" Git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'gregsexton/gitv'

" Ruby
NeoBundleLazy 'marcus/rsense'
NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', {
            \ 'autoload': { 'filetypes': ['ruby'] },
            \ 'depends': 'marcus/rsense'
            \ }
NeoBundle 'szw/vim-tags'
NeoBundle 'thinca/vim-ref'
NeoBundleLazy 'yuku-t/vim-ref-ri', {
            \ 'autoload': { 'filetypes': ['ruby'] },
            \ 'depends': 'thinca/vim-ref',
            \ }
NeoBundle 'tpope/vim-endwise'

NeoBundle 'scrooloose/syntastic'

NeoBundle 'thinca/vim-localrc'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'powerman/vim-plugin-AnsiEsc'
NeoBundle 'tmux-plugins/vim-tmux-focus-events'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'rhysd/clever-f.vim'

NeoBundleLazy 'tpope/vim-rails'

" Style
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'

" Unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'basyura/unite-rails'
NeoBundle 'Shougo/neomru.vim'

" Type scripts
NeoBundle 'noprompt/vim-yardoc'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'tpope/vim-markdown'

call neobundle#end()
filetype plugin indent on
syntax on
NeoBundleCheck
" }}}

" ------------------------------
" Rsense {{{
" ------------------------------
" Set g:rsenseHome in ~/.vimrc.local
let g:rsenseUseOmniFunc = 1
" }}}

" ------------------------------
" neocomplete.vim {{{
" ------------------------------
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
" }}}

" ------------------------------
" rubocop {{{
" ------------------------------
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_mode_map = {
            \ 'mode': 'passive',
            \ 'active_filetypes': ['javascript', 'scss', 'coffee'],
            \ 'passive_filetypes': ['ruby']
            \ }
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_coffee_checkers = ['coffeelint']
" }}}

" ------------------------------
" vim-easymotion {{{
" ------------------------------
let g:EasyMotion_mapping_j = '<C-j>'
let g:EasyMotion_mapping_k = '<C-k>'
" }}}

" ------------------------------
" vim-indent-guides {{{
" ------------------------------
let g:indent_guides_auto_colors = 1 " read help txt
let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 0
let g:indent_guides_color_change_percent = 10
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
" }}}

" ------------------------------
" lightline {{{
" ------------------------------
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'mode_map': {'c': 'NORMAL'},
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
            \   'right': [ [ 'syntastic', 'lineinfo'],
            \              [ 'percent' ],
            \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'modified': 'MyModified',
            \   'readonly': 'MyReadonly',
            \   'fugitive': 'MyFugitive',
            \   'filename': 'MyFilename',
            \   'fileformat': 'MyFileformat',
            \   'filetype': 'MyFiletype',
            \   'fileencoding': 'MyFileencoding',
            \   'mode': 'MyMode',
            \ },
            \ 'component_type': {
            \   'syntastic': 'error'
            \ }
            \ }

"            \ 'component_expand': {
"            \   'syntastic': 'SyntasticStatuslineFlag'
"            \ },

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
            \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
            \  &ft == 'unite' ? unite#get_status_string() :
            \  &ft == 'vimshell' ? vimshell#get_status_string() :
            \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
            \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" augroup AutoSyntastic
"     au!
"     au BufWritePost *.rb,*.js call s:syntastic()
" augroup END
" function! s:syntastic()
"     SyntasticCheck
"     call lightline#update()
" endfunction
" }}}
"
" ------------------------------
" unite {{{
" ------------------------------
" default profile
call unite#custom#profile('default', 'context', {
      \ 'winwidth': 50,
      \ 'start_insert': 1
      \ })
" ctrlp.vim like behavior
call unite#custom#profile('ctrlp', 'context', {
      \ 'start_insert': 1,
      \ 'winheight': 20,
      \ 'direction': 'botright',
      \ 'buffer_name': 'async'
      \ })
call unite#custom#source('file_rec/async,file_rec/git', 'ignore_pattern',
      \ '\v\/doc\/|.vagrant|.git\/|\/cache\/|.(png|gif|jpeg|jpg)$'
      \ )
function! DispatchUniteFileRecAsyncOrGit()
  if isdirectory(getcwd()."/.git")
    " If current dir is root git directory.
    Unite -profile-name=ctrlp file_rec/git
  else
    Unite -profile-name=ctrlp file_rec/async:!
  endif
endfunction
nnoremap <silent> <C-p> :<C-u>call DispatchUniteFileRecAsyncOrGit()<CR>

if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif

" The prefix key.
nnoremap [unite]  <Nop>
nmap     <space>  [unite]

" unite/rails settings
" --------------------
nnoremap <silent> [unite]p :<C-u>Unite -profile-name=ctrlp source<CR>rails/

" neomru
" ------
"call unite#custom#source('file_mru', 'matchers', '.*\/$\|.*Application\ Data.*')
nnoremap <silent> [unite]m :<C-u>Unite -profile-name=ctrlp neomru/file<CR>

nnoremap <silent> [unite]u :<C-u>UniteWithBufferDir
            \ -buffer-name=files file file/new<CR>
nnoremap <silent> [unite]c :<C-u>UniteWithCurrentDir
            \ -buffer-name=files buffer bookmark<CR>
nnoremap <silent> [unite]/ :<C-u>Unite grep:.<CR>
let g:unite_source_history_yank_enable = 1
nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]b :<C-u>Unite -quick-match buffer<CR>
"nnoremap <silent> [unite]h :<C-u>Unite help<CR>
nnoremap <silent> [unite]t :<C-u>Unite
            \ -no-start-insert -immediately tab:no-current<CR>
nnoremap <silent> [unite]w :<C-u>Unite
            \ -no-start-insert -immediately window:no-current<CR>
nnoremap <silent> [unite]o :<C-u>Unite
            \ -vertical -no-quit -toggle -direction=botright
            \ -buffer-name=outline -winwidth=40 outline<CR>

augroup UniteFileType
    autocmd!
"    autocmd FileType vim    nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit help<CR>
"    autocmd FileType sh     nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/man<CR>
"    autocmd FileType erlang nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/erlang<CR>
"    autocmd FileType ruby   nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/ri<CR>
"    autocmd FileType python nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/pydoc<CR>
"    autocmd FileType perl   nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/perldoc<CR>
"
    autocmd FileType unite call s:unite_my_settings()
augroup END

function! s:unite_my_settings()
    " Overwrite settings
    nmap <buffer><ESC>  <Plug>(unite_exit)
    nmap <buffer><C-c>  <Plug>(unite_exit)
    nmap <buffer><C-x>  <Plug>(unite_redraw)
    "imap <buffer>jj     <Plug>(unite_insert_leave)
    imap <buffer><C-w>  <Plug>(unite_delete_backward_path)

    " <C-l>: manual neocomplete completion.
    "inoremap <buffer><C-l>  <C-x><C-u><C-p><Down>

    nmap <buffer><expr><C-d>  unite#do_action('delete')
    imap <buffer><expr><C-d>  unite#do_action('delete')
    nmap <buffer><expr><C-b>  unite#do_action('bookmark')
    imap <buffer><expr><C-b>  unite#do_action('bookmark')
    nmap <buffer><expr><C-k>  unite#do_action('above')
    imap <buffer><expr><C-k>  unite#do_action('above')
    nmap <buffer><expr><C-i>  unite#do_action('left')
    imap <buffer><expr><C-i>  unite#do_action('left')
endfunction
" }}}

" ------------------------------
" gitgutter {{{
" ------------------------------
let g:gitgutter_enabled = 0
let g:gitgutter_eager = 0
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>
" }}}

" ------------------------------
" gitv {{{
" ------------------------------
augroup Gitv
    autocmd!
    autocmd FileType gitv call s:my_gitv_settings()
    autocmd FileType git setlocal nofoldenable foldlevel=0
augroup END
function! s:gitv_get_current_hash()
    return matchstr(getline('.'), '\[\zs.\{7\}\ze\]$')
endfunction
function! s:toggle_gitv_folding()
    if &filetype ==# 'git'
        setlocal foldenable!
    endif
endfunction
function! s:my_gitv_settings()
    setlocal iskeyword+=/,-,.
    nnoremap <silent><buffer> C :<C-u>Git checkout <C-r><C-w><CR>
    nnoremap <buffer> <Space>rb :<C-u>Git rebase <C-r>=<SID>gitv_get_current_hash()<CR><Space>
    nnoremap <buffer> <Space>R :<C-u>Git revert <C-r>=<SID>gitv_get_current_hash()<CR><CR>
    nnoremap <buffer> <Space>h :<C-u>Git cherry-pick <C-r>=<SID>gitv_get_current_hash()<CR><CR>
    nnoremap <buffer> <Space>rh :<C-u>Git reset --hard <C-r>=<SID>gitv_get_current_hash()<CR>
    nnoremap <buffer> G :<C-u>Gbrowse <C-r>=<SID>gitv_get_current_hash()<CR><CR>
    nnoremap <silent><buffer> t :<C-u>windo call <SID>toggle_gitv_folding()<CR>1<C-w>w
endfunction
" }}}

" ------------------------------
" General {{{
" ------------------------------
set clipboard+=unnamed       " share clipboard with other systems
set helplang=en,ja           " search en help docs if exists

inoremap # X<BS>#
set shiftround
set virtualedit=block        " allow virtual edit in visual block ..
set ambiwidth=double
set autoread                 " prevent W11 warning
set visualbell t_vb=         " No beep sound
set nolazyredraw             " don't redraw while executing macros
set report=0                 " tell us about changes

set encoding=utf-8           " Use utf-8
set termencoding=utf-8       " ..
set fileencodings=utf-8      " ..
set fileformats=unix,mac,dos " Automatic end-of-file format detection

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
" }}}

" ------------------------------
" Behavior {{{
" ------------------------------
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

" Treat octal and hexadecimal number as decimal number
" octal  Numbers that start with a zero will be considered to be octal
"        Example: Using CTRL-A on "007" results in "010"
" hex    Numbers starting with "0x" or "0X" will be considered to be hexadecimal
"        Example: Using CTRL-X on "0x100" results in "0x0ff"
set nrformats+=octal,hex
" }}}

" ------------------------------
" Mapping {{{
" ------------------------------
let mapleader=','           " Lead with ,

" Jump to vimrc
nnoremap <space>v :<C-u>edit $HOME/.vimrc<CR>
" Reload vimrc setting
nnoremap <space>s :<C-u>source $HOME/.vimrc<CR>
" Create new tab
cnoremap <C-t> <C-u>tabnew<CR>
nnoremap <C-h> :<C-u>tabprevious<CR>
nnoremap <C-l> :<C-u>tabnext<CR>
" }}}

" ------------------------------
" Style {{{
" ------------------------------
syntax on
set background=dark
colorscheme base16-default

set listchars=tab:▸\ ,eol:¬
set list
set showcmd                 " display incomplete commands
set number                  " line numbers
set cmdheight=1             " command line height
set shortmess=filtoO        " shorten messages
set scrolloff=5             " Keep at least 5 lines above and below the cursor
set laststatus=2            " The last window always have status line
set showmatch               " brackets/braces that is
set matchtime=3             " duration to show matching brace (1/10 sec)
set ruler                   " show the cursor position all the time
set foldmethod=marker

if v:version >= 703
  set colorcolumn=+1
endif

if has("mouse") " Enable the use of the mouse in all modes
  set mouse=a
endif

" highlight cursor line in current window
augroup cch
    autocmd!
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END
highlight clear CursorLine
highlight CursorLine ctermbg=black

augroup whitespace
    autocmd!
    autocmd VimEnter,WinEnter ruby,javascript,coffee match WhitespaceEOL /\s\+$/
augroup END
highlight WhitespaceEOL ctermbg=red guibg=red
highlight CursorLineNr ctermfg=DarkYellow guifg=DarkYellow
" }}}

" ------------------------------
" Search {{{
" ------------------------------
set history=100             " keep 100 lines of command line histories
set ignorecase
set smartcase
set wrapscan                " Searches wrap around the end of the file
" While typing a search command, show where the pattern matches
set incsearch
set hlsearch                " highlighting matches
" turn off highlight by Esc x 2
nmap <ESC><ESC> :<C-u>nohlsearch<CR><ESC>
augroup Search
    autocmd!
    autocmd QuickFixCmdPost *grep cwindow
augroup END
" }}}

" source $HOME/.vim/rc/general.vimrc
" source $HOME/.vim/rc/behavior.vimrc
" source $HOME/.vim/rc/mapping.vimrc
" source $HOME/.vim/rc/ui.vimrc
" source $HOME/.vim/rc/search.vimrc
" source $HOME/.vim/rc/ftdetects.vimrc
" source $HOME/.vim/rc/plugins.vimrc
" source $HOME/.vim/rc/highlight.vimrc

if has('mac')
    source $HOME/.vim/rc/mac.vimrc
endif

if exists("$HOME/.vimrc.local")
    source $HOME/.vimrc.local
endif

" vim: set filetype=vim :

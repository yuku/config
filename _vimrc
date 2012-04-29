"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"                       _                                    "
"                _   __(_)___ ___  __________                "
"               | | / / / __ `__ \/ ___/ ___/                "
"               | |/ / / / / / / / /  / /__                  "
"               |___/_/_/ /_/ /_/_/   \___/                  "
"                                                            "
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

"" General {{{1
set nocompatible
set clipboard=unnamed

" Leader
let mapleader='\'

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

syntax on
" solarized - http://ethanschoonover.com/solarized
colorscheme solarized
set background=dark

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

"" Short cut keys {{{1

" Jump to vimrc
nnoremap <space><space> :<C-u>edit $DOTFILES/_vimrc<CR>
" Reload vimrc setting
nnoremap <space>s :<C-u>source $DOTFILES/_vimrc<CR>

"" Backup {{{1
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

"" Search {{{1
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

"" Display {{{1
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
highlight WhitespaceEOL ctermbg=red
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

"" Tab {{{1
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround

"" Vim Tab {{{1
cnoremap <C-t> <C-u>tabnew<CR>
"nnoremap <silent> <C-l> :<C-u>tabnext<CR>
"nnoremap <silent> <C-h> :<C-u>tabprevious<CR>

"" Indent {{{1
set autoindent
set smartindent

"" Character encoding {{{1
" Use utf-8
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8
" Automatic end-of-file format detection
set fileformats=unix,mac,dos

"" Plugins {{{1
"" NeoBundle {{{2
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
" let NeoBundle manage NeoBundle
NeoBundle 'Shougo/neobundle.vim'

"" for Version > 702 only {{{2
if v:version > 702
  "" unite.vim {{{3
  NeoBundle 'Shougo/unite.vim'

  let g:unite_enable_split_vertically = 1
  let g:unite_winwidth = 50
  let g:unite_enable_start_insert = 1
  let g:unite_source_file_mru_ignore_pattern = '.*\/$\|.*Application\ Data.*'
  nnoremap [unite] <Nop>
  nmap     <space>u [unite]
  nnoremap <silent> [unite]u :<C-u>UniteWithBufferDir -horizontal -buffer-name=files file file/new<CR>
  nnoremap <silent> [unite]c :<C-u>UniteWithCurrentDir -horizontal -buffer-name=files buffer file_mru<CR>
  nnoremap <silent> [unite]i :<C-u>Unite -buffer-name=files buffer_tab<CR>
  nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=files bookmark<CR>
  nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
  nnoremap <silent> [unite]l :<C-u>Unite line<CR>
  nnoremap <silent> [unite]t :<C-u>Unite -immediately tab:no-current<CR>
  nnoremap <silent> [unite]m :<C-u>Unite -no-empty git_modified<CR>

  nnoremap <silent> <C-g>    :<C-u>Unite vcs_grep/git<CR>
  nnoremap <silent> <C-h>    :<C-u>Unite -start-insert help<CR>

  autocmd FileType *      nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/man<CR>
  autocmd FileType erlang nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/erlang<CR>
  autocmd FileType ruby   nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/ri<CR>
  autocmd FileType python nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/pydoc<CR>
  autocmd FileType perl   nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/perldoc<CR>

  autocmd FileType unite call s:unite_my_settings()
  function! s:unite_my_settings()
    " Overwrite settings
    nmap <buffer><ESC>  <Plug>(unite_exit)
    nmap <buffer><C-c>  <Plug>(unite_exit)
    "imap <buffer>jj     <Plug>(unite_insert_leave)
    imap <buffer><C-w>  <Plug>(unite_delete_backward_path)


    " <C-l>: manual neocomplecache completion.
    inoremap <buffer><C-l>  <C-x><C-u><C-p><Down>

    nmap <buffer><expr><C-d>  unite#do_action('delete')
    imap <buffer><expr><C-d>  unite#do_action('delete')
    nmap <buffer><expr><C-b>  unite#do_action('bookmark')
    imap <buffer><expr><C-b>  unite#do_action('bookmark')
    nmap <buffer><expr><C-k>  unite#do_action('above')
    imap <buffer><expr><C-k>  unite#do_action('above')
    nmap <buffer><expr><C-i>  unite#do_action('left')
    imap <buffer><expr><C-i>  unite#do_action('left')
  endfunction

  " Unite Plugins
    "" unite-git_grep {{{4
    NeoBundle 'sgur/unite-git_grep'

    "" unite-git {{{4
    NeoBundle 'taka84u9/unite-git'

    "" unite-outline {{{4
    NeoBundle 'h1mesuke/unite-outline'

    "" unite-help {{{4
    NeoBundle 'tsukkee/unite-help'


  "" vim-ref {{{3
  NeoBundle 'thinca/vim-ref'

  let g:ref_perldoc_complete_head = 1
  let g:ref_open = 'vsplit'

    " vim-ref Plugins
    "" vim-ref-ri {{{4
    NeoBundle 'taka84u9/vim-ref-ri'

  "" neocomplcache {{{3
  NeoBundle 'Shougo/neocomplcache'
  NeoBundle 'Shougo/neocomplcache-snippets-complete'

  "imap <C-k> <Plug>(neocomplcache_snippets_expand)
  "smap <C-k> <Plug>(neocomplcache_snippets_expand)

  let g:neocomplcache_enable_auto_select = 1

  " Use neocomplcache.
  let g:neocomplcache_enable_at_startup = 1
  " Use underbar completion.
  let g:neocomplcache_enable_underbar_completion = 1
  " Set minimum syntax keyword length.
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

  " Use smartcase.
  let g:neocomplcache_enable_smart_case = 1
  " Use camel case completion.
  let g:neocomplcache_enable_camel_case_completion = 1
  " Select with <TAB>
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

  let g:neocomplcache_ctags_arguments_list = {
        \ 'perl' : '-R -h ".pm"'
        \ }

  let g:neocomplcache_snippets_dir = "~/.vim/snippets"
  " Define dictionary.
  let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default'    : '',
        \ 'perl'       : $HOME . '/.vim/dict/perl.dict'
        \ }

  " Define keyword.
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

  "" Vimfiler {{{3
  NeoBundle 'Shougo/vimfiler'

  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_safe_mode_by_default = 0

  "" indent-guides {{{3
  NeoBundle 'nathanaelkane/vim-indent-guides'

  let g:indent_guides_auto_colors = 0 " read help txt
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_color_change_percent = 30
  "let g:indent_guides_guide_size = 1

  "" localrc {{{3
  NeoBundle "thinca/vim-localrc"

  "" syntastic {{{3
  NeoBundle "scrooloose/syntastic"

  let g:syntastic_mode_map = { 'mode': 'passive',
        \ 'active_filetypes': ['ruby', 'javascript', 'python', 'cpp', 'coffeescript'],
        \ 'passive_filetypes': [] }

  "" vimproc {{{3
  NeoBundle 'Shougo/vimproc'

endif "}}}2

"" All version {{{2

  "" vim-fugitive {{{3
  NeoBundle 'tpope/vim-fugitive'

  "" vim-surround {{{3
  NeoBundle 'tpope/vim-surround'
  let g:surround_{char2nr("#")} = "{# \r #}"
  let g:surround_{char2nr("*")} = "/* \r */"
  let g:surround_{char2nr("p")} = "<?php \r ?>"

  "" rails.vim {{{3
  NeoBundle 'tpope/vim-rails'

  "" quick run {{{3
  NeoBundle 'thinca/vim-quickrun'

  nmap <Leader>r <plug>(quickrun)

  "" EasyMotion {{{3
  NeoBundle 'Lokaltog/vim-easymotion'

  let g:EasyMotion_leader_key = '<Space>j'

  "" Gist.vim {{{3
  NeoBundle "mattn/gist-vim"
  NeoBundle "mattn/webapi-vim"

  let g:gist_detect_filetype = 1
  let g:github_user = "taka84u9"
  let g:github_token = "e9f46f535783ba347658b0569a450f74"

  "" vim-coffee-script {{{3
  NeoBundle "kchmck/vim-coffee-script"

  nnoremap <silent> <Space>c :CoffeeCompile watch vert <CR><C-w>h
  let coffee_compile_vert = 1

  "" vim-powerline {{{3
  NeoBundle "Lokaltog/vim-powerline"

  "" vim-less {{{3
  NeoBundle "groenewege/vim-less"

  "" vim-perl {{{3
  NeoBundle 'petdance/vim-perl'

  "" foldCC {{{3
  NeoBundle 'LeafCage/foldCC'
  set foldtext=FoldCCtext()
  hi Folded ctermfg=DarkBlue
  hi FoldColumn ctermfg=LightGrey

  filetype plugin indent on
  "
  " Brief help
  " :NeoBundleList       - list configured bundles
  " :NeoBundleInstall(!) - install(update) bundles
  " :NeoBundleClean(!)   - confirm(or auto-approve) removal of unused bundles
  "

" }}}2

"" Source {{{1

autocmd BufRead,BufNewFile Gemfile set filetype=ruby
autocmd BufRead,BufNewFile *.json set filetype=javascript

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

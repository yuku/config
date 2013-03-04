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
set clipboard+=unnamed      " share clipboard with other systems

"" Text Formatting

set autoindent              " automatic indent new lines
set smartindent             " be smart about it
inoremap # X<BS>#
set wrap                    " wrap lines
set softtabstop=2
set shiftwidth=2
set shiftround
set tabstop=8
set expandtab               " expand tabs to spaces
set nosmarttab              " fuck tabs
set formatoptions+=n        " support for numbered/bullet lists
set wrapmargin=0
set virtualedit=block       " allow virtual edit in visual block ..

set textwidth=79            " wrap at 79 chars by default
if v:version >= 703
  set colorcolumn=+1
endif

"" Persistent undo
if has('persistent_undo')
    set undodir=~/.vim/undo
    set undofile
endif


"" Remapping

let mapleader=','           " Lead with ,
" Jump to vimrc
nnoremap <space>v :<C-u>edit $HOME/.vimrc<CR>
" Reload vimrc setting
nnoremap <space>s :<C-u>source $HOME/.vimrc<CR>
" Create new tab
cnoremap <C-t> <C-u>tabnew<CR>
nnoremap <C-h> :<C-u>tabprevious<CR>
nnoremap <C-l> :<C-u>tabnext<CR>

"" UI

set ruler                   " show the cursor position all the time
" highlight cursor line in current window
augroup cch
  autocmd!
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


"" ftdetects
augroup FileTypeDetect
    autocmd!
    autocmd BufRead,BufNewFile Capfile,Gemfile      setf ruby
    autocmd BufRead,BufNewFile *.json               setf javascript
    autocmd BufRead,BufNewFile *.md                 setf markdown
    autocmd BufRead,BufNewFile *.PL,*.psgi,*.t      setf perl
    autocmd BufRead,BufNewFile .tmux.conf,tmux.conf setf tmux
    autocmd BufRead,BufNewFile *.jade               setf jade
    autocmd BufRead,BufNewFile *.less               setf less
    autocmd BufRead,BufNewFile *.coffee             setf coffee
    autocmd BufRead,BufNewFile *.hatena             setf hatena
    autocmd BufRead,BufNewFile *.txt                setf hybrid
augroup END

augroup FileTypePlugin
    autocmd FileType htmldjango setlocal ts=4 sts=4 sw=4
    autocmd FileType int-gosh   setlocal nonu
    autocmd FileType int-pry    setlocal nonu
    autocmd FileType int-python setlocal nonu
    autocmd FileType java       setlocal ts=4 sts=4 sw=4
    autocmd FileType markdown   setlocal tw=0
    autocmd FileType perl       setlocal ts=4 sts=4 sw=4
    autocmd FileType python     setlocal ts=4 sts=4 sw=4 si cinw=if,elif,else,for,while,try,except,finally,def,class
    autocmd FileType rst        setlocal tw=0
    autocmd FileType vim        setlocal ts=4 sts=4 sw=4
    autocmd FileType vimfiler   setlocal nonu
    autocmd FileType vimshell   setlocal nonu
augroup END


filetype off
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', { 'build': {
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac'    : 'make -f make_mac.mak',
    \     'unix'   : 'make -f make_unix.mak',
    \    },
    \ }

NeoBundle 'Shougo/unite.vim'
NeoBundle 'taka84u9/unite-git'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'tsukkee/unite-help'
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
nnoremap <silent> [unite]o :<C-u>Unite -vertical -no-quit -winwidth=30 -no-start-insert outline<CR>
nnoremap <silent> [unite]t :<C-u>Unite -immediately -horizontal tab:no-current<CR>
nnoremap <silent> [unite]m :<C-u>Unite -no-empty git_modified<CR>

nnoremap <silent> <C-g>    :<C-u>Unite vcs_grep/git<CR>
"nnoremap <silent> <C-h>    :<C-u>Unite -start-insert help<CR>


augroup UniteFileType
    autocmd!
    autocmd FileType vim    nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit help<CR>
    autocmd FileType sh     nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/man<CR>
    autocmd FileType erlang nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/erlang<CR>
    autocmd FileType ruby   nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/ri<CR>
    autocmd FileType python nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/pydoc<CR>
    autocmd FileType perl   nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/perldoc<CR>

    autocmd FileType unite call s:unite_my_settings()
augroup END

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

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'honza/snipmate-snippets'
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"
let g:neocomplcache_max_list = 10
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Select with <TAB>
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

let g:neocomplcache_snippets_dir = "~/.vim/snippets,~/.vim/bundle/snipmate-snippets/snippets"
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default'   : '',
            \ 'perl'      : $HOME.'/.vim/dict/perl.dict',
            \ 'javascrip' : $HOME.'/.vim/dict/javascript.dict'
            \ }

" Define keywork.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

let g:neosnippet#enable_snipmate_compatibility = 1

NeoBundle 'Shougo/vimfiler'
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
nnoremap <silent><space>e :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -toggle -no-quit<CR>

NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'thinca/vim-quickrun'
nmap <Leader>r <plug>(quickrun)
let g:quickrun_config = {}
let g:quickrun_config.perl = {'command': 'perl', 'cmdopt': '-MProject::Libs'}

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'

NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_auto_colors = 0 " read help txt
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 30

NeoBundle 'Lokaltog/vim-easymotion'
let g:EasyMotion_leader_key = '<Space>j'

NeoBundle 'Lokaltog/vim-powerline', 'develop'

NeoBundle "scrooloose/syntastic"
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['ruby', 'javascript', 'python', 'perl'],
            \ 'passive_filetypes': [] }

NeoBundle "goldfeld/vim-seek"

NeoBundleLazy 'tpope/vim-markdown'
NeoBundleLazy 'mattn/zencoding-vim'
NeoBundleLazy 'digitaltoad/vim-jade'
NeoBundleLazy 'groenewege/vim-less'
NeoBundleLazy 'petdance/vim-perl'
NeoBundleLazy 'kchmck/vim-coffee-script'
NeoBundleLazy 'tpope/vim-rails'
NeoBundleLazy "motemen/xslate-vim"
NeoBundleLazy "motemen/hatena-vim"
NeoBundle "HybridText"
augroup LazyBundle
    autocmd!
    autocmd FileType markdown NeoBundleSource vim-markdown
    "autocmd FileType html NeoBundleSource zencoding-vim
    autocmd FileType jade NeoBundleSource vim-jade
    autocmd FileType less NeoBundleSource vim-less
    autocmd FileType perl NeoBundleSource vim-perl
    autocmd FileType coffee NeoBundleSource vim-coffee-script
    "autocmd FileType ruby NeoBundleSource vim-rails
    autocmd FileType xslate NeoBundleSource xslate-vim
    autocmd FileType hatena NeoBundleSource hatena-vim
    " autocmd FileType hybrid NeoBundleSource HybridText
augroup END

NeoBundleLazy "rodjek/vim-puppet"
autocmd BufRead,BufNewFile *.pp set filetype=puppet
autocmd FileType puppet NeoBundleSource vim-puppet

filetype plugin indent on

" Installation check
NeoBundleCheck

" vim: set filetype=vim :

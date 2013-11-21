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
set helplang=ja,en          " search ja help docs if exists

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
set listchars=tab:▸\ ,eol:¬
set nolist
set ambiwidth=double
set autoread                " prevent W11 warning

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
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

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
set shortmess=filtoO        " shorten messages
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

" highlight whitespaces
highlight WhitespaceEOL ctermbg=red
augroup whitespace
    autocmd!
    autocmd VimEnter,WinEnter * match WhitespaceEOL /\s\+$/
augroup END


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
nmap <ESC><ESC> :<C-u>nohlsearch<CR><ESC>
augroup Search
    autocmd!
    autocmd QuickFixCmdPost *grep cwindow
augroup END

"" Character encoding

set encoding=utf-8          " Use utf-8
set termencoding=utf-8      " ..
set fileencodings=utf-8     " ..
" Automatic end-of-file format detection
set fileformats=unix,mac,dos

""
augroup Redraw
    autocmd!
    autocmd FocusGained * redraw!
augroup END


"" ftdetects
augroup FileTypeDetect
    autocmd!
    autocmd BufRead,BufNewFile Capfile,Gemfile      setfiletype ruby
    autocmd BufRead,BufNewFile *.json               setfiletype javascript
    autocmd BufRead,BufNewFile *.md                 setfiletype markdown
    autocmd BufRead,BufNewFile *.PL,*.psgi,*.t      setfiletype perl
    autocmd BufRead,BufNewFile .tmux.conf,tmux.conf setfiletype tmux
    autocmd BufRead,BufNewFile *.jade               setfiletype jade
    autocmd BufRead,BufNewFile *.less               setfiletype less
    autocmd BufRead,BufNewFile *.coffee             setfiletype coffee
    autocmd BufRead,BufNewFile *.hatena             setfiletype hatena
    autocmd BufRead,BufNewFile *.pp                 setfiletype puppet
    autocmd BufRead,BufNewFile *.scss               setfiletype scss
    autocmd BufRead,BufNewFile *.ts                 setfiletype typescript
augroup END

augroup FileTypePlugin
    autocmd!
    autocmd FileType css        setlocal ts=4 sts=4 sw=4
    autocmd FileType gitcommit  setlocal textwidth=69
    autocmd FileType htmldjango setlocal ts=4 sts=4 sw=4
    autocmd FileType html       setlocal ts=4 sts=4 sw=4
    autocmd FileType int-gosh   setlocal nonu
    autocmd FileType int-pry    setlocal nonu
    autocmd FileType int-python setlocal nonu
    autocmd FileType java       setlocal ts=4 sts=4 sw=4
    autocmd FileType markdown   setlocal tw=0
    autocmd FileType perl       setlocal ts=4 sts=4 sw=4
    autocmd FileType python     setlocal ts=4 sts=4 sw=4 si cinw=if,elif,else,for,while,try,except,finally,def,class
    autocmd FileType rst        setlocal tw=0
    autocmd FileType scss       setlocal ts=4 sts=4 sw=4
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2
    autocmd FileType typescript setlocal ts=4 sts=4 sw=4
    autocmd FileType vim        setlocal ts=4 sts=4 sw=4
    autocmd FileType vimfiler   setlocal nonu
    autocmd FileType vimshell   setlocal nonu
    autocmd FileType zsh        setlocal ts=4 sts=4 sw=4
augroup END

"" Go lang
if $GOROOT != ''
    set runtimepath+=$GOROOT/misc/vim
    "exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
endif

filetype off
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
            \'build': {
            \     'windows' : 'make -f make_wingw32.mak',
            \     'cygwin'  : 'make -f make_cygwin.mak',
            \     'mac'     : 'make -f make_mac.mak',
            \     'unix'    : 'make -f make_unix.mak',
            \    },
            \ }

NeoBundle 'Shougo/unite.vim'
NeoBundle 'yuku-t/unite-git'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite-help'
NeoBundle 'joker1007/unite-pull-request', {
            \ 'depends': 'mattn/webapi-vim' }
"let g:unite_enable_split_vertically = 1
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif
let g:unite_winwidth = 50
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
call unite#custom#source('file_rec/async', 'ignore_pattern', '\(png\|gif\|jpeg\|jpg\)$')
call unite#custom#source('file_mru', 'ignore_pattern', '.*\/$\|.*Application\ Data.*')
nnoremap <silent> <C-p>    :<C-u>Unite file_rec/async:!<CR>
nnoremap <silent> <space>u :<C-u>UniteWithBufferDir file file/new<CR>
nnoremap <silent> <space>/ :<C-u>Unite grep:.<CR>
nnoremap <silent> <space>y :<C-u>Unite history/yank<CR>
nnoremap <silent> <space>b :<C-u>Unite -quick-match buffer<CR>
nnoremap <silent> <space>h :<C-u>Unite help<CR>
nnoremap <silent> <space>m :<C-u>Unite git_modified<CR>
nnoremap <silent> <space>a :<C-u>Unite -vertical -no-quit -no-focus -no-start-insert -toggle -direction=topleft -buffer-name=async -winwidth=30 file_rec/async<CR>
nnoremap <silent> <space>o :<C-u>Unite -vertical -no-quit -toggle -direction=botright -buffer-name=outline -winwidth=40 outline<CR>
"nnoremap [unite] <Nop>
"nmap     <space>u [unite]
"nnoremap <silent> [unite]u :<C-u>UniteWithBufferDir -horizontal -buffer-name=files file file/new<CR>
"nnoremap <silent> [unite]c :<C-u>UniteWithCurrentDir -horizontal -buffer-name=files buffer file_mru<CR>
"nnoremap <silent> [unite]i :<C-u>Unite -horizontal -buffer-name=files buffer_tab<CR>
"nnoremap <silent> [unite]b :<C-u>Unite -horizontal -buffer-name=files bookmark<CR>
"nnoremap <silent> [unite]r :<C-u>Unite -horizontal -buffer-name=register register<CR>
"nnoremap <silent> [unite]o :<C-u>Unite -vertical -no-quit -winwidth=30 -no-start-insert outline<CR>
"nnoremap <silent> [unite]t :<C-u>Unite -horizontal -immediately -horizontal tab:no-current<CR>
"nnoremap <silent> [unite]m :<C-u>Unite -horizontal -no-empty git_modified<CR>

"nnoremap <silent> <C-g>    :<C-u>Unite vcs_grep/git<CR>
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
    nmap <buffer><C-x> <Plug>(unite_redraw)
    "imap <buffer>jj     <Plug>(unite_insert_leave)
    imap <buffer><C-w>  <Plug>(unite_delete_backward_path)

    " <C-l>: manual neocomplete completion.
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

if has('lua')
    NeoBundle 'Shougo/neocomplete'
    NeoBundle 'Shougo/neosnippet'
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#min_syntax_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Use underbar completion.
    let g:neocomplete#enable_underbar_completion = 1
    "
    let g:neocomplete#max_list = 10
    " Use camel case completion.
    let g:neocomplete#enable_camel_case_completion = 1

    let g:neocomplete#force_overwrite_completefunc = 1
    " Select with <TAB>
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

    " Define dictionary.
    let g:neocomplete#dictionary_filetype_lists = {
                \ 'default'   : '',
                \ 'perl'      : $HOME.'/.vim/dict/perl.dict',
                \ 'javascrip' : $HOME.'/.vim/dict/javascript.dict'
                \ }

    " Define keyword.
    if !exists('g:neocomplete_keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    let g:neocomplete#snippets_dir = "~/.vim/snippets,~/.vim/bundle/snipmate-snippets/snippets"

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
    return neocomplete#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction

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
else
    NeoBundle 'Shougo/neocomplcache'
endif

NeoBundle 'Shougo/vimfiler', {'depends': 'Shougo/unite.vim'}
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
nnoremap <silent><space>e :<C-u>VimFilerCurrentDir -explorer -find -split -simple -winwidth=30 -toggle -no-quit<CR>
augroup VimFiler
    autocmd!
    autocmd FileType vimfiler nnoremap <buffer><C-j> :<C-u>call EasyMotion#JK(0, 0)<CR>
augroup END

NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-localrc'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'airblade/vim-gitgutter'
let g:gitgutter_enabled = 0
let g:gitgutter_eager = 0
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>
NeoBundle 'gregsexton/gitv'
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

NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_auto_colors = 1 " read help txt
let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 0
let g:indent_guides_color_change_percent = 10
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

NeoBundle 'Lokaltog/vim-easymotion'
let g:EasyMotion_mapping_j = '<C-j>'
let g:EasyMotion_mapping_k = '<C-k>'

NeoBundle 'bling/vim-airline'
" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline#extensions#branch#symbol = ' '
let g:airline#extensions#readonly#symbol = ''
let g:airline_linecolumn_prefix = ' '
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1

NeoBundle 'scrooloose/syntastic'
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['javascript', 'python', 'perl'],
            \ 'passive_filetypes': [] }
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_quiet_warnings = 0
let g:syntastic_javascript_checkers = ['jshint']

NeoBundle 'goldfeld/vim-seek'
NeoBundle "Align"

NeoBundleLazy 'tpope/vim-markdown',        {'autoload': {'filetypes': ['markdown']}}
NeoBundleLazy 'cakebaker/scss-syntax.vim', {'autoload': {'filetypes': ['scss']}}
NeoBundleLazy 'mattn/zencoding-vim',       {'autoload': {'filetypes': ['html', 'erb']}}
NeoBundleLazy 'othree/html5.vim',          {'autoload': {'filetypes': ['html']}}
NeoBundleLazy 'digitaltoad/vim-jade',      {'autoload': {'filetypes': ['jade']}}
NeoBundleLazy 'groenewege/vim-less',       {'autoload': {'filetypes': ['less']}}
NeoBundleLazy 'petdance/vim-perl',         {'autoload': {'filetypes': ['perl']}}
NeoBundleLazy 'kchmck/vim-coffee-script',  {'autoload': {'filetypes': ['coffee']}}
augroup CoffeeScript
    autocmd!
    autocmd FileType coffee call s:my_coffee_settings()
augroup END
function! s:my_coffee_settings()
    nnoremap <silent><buffer> <leader>c :<C-u>CoffeeWatch vertical<CR>
    vnoremap <silent><buffer> <leader>c :<C-u>'<,'>CoffeeCompile vertical<CR>
endfunction
NeoBundleLazy 'motemen/xslate-vim',        {'autoload': {'filetypes': ['xslate']}}
NeoBundleLazy 'motemen/hatena-vim',        {'autoload': {'filetypes': ['hatena']}}
NeoBundleLazy 'nginx.vim',                 {'autoload': {'filetypes': ['nginx']}}
NeoBundleLazy 'rodjek/vim-puppet',         {'autoload': {'filetypes': ['puppet']}}
NeoBundleLazy 'vim-ruby/vim-ruby',         {'autoload': {'filetypes': ['ruby', 'eruby', 'haml']}}
NeoBundleLazy 'skwp/vim-rspec',            {'autoload': {'filetypes': ['ruby']}}
NeoBundleLazy 'ruby-matchit',              {'autoload': {'filetypes': ['ruby', 'eruby', 'haml']}}
NeoBundleLazy 'pangloss/vim-javascript',   {'autoload': {'filetypes': ['javascript']}}
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
NeoBundleLazy 'thinca/vim-quickrun',      {'autoload': {'filetypes': ['ruby', 'python', 'perl', 'sh']}}
nmap <Leader>r <plug>(quickrun)
let g:quickrun_config = {}
let g:quickrun_config.perl = {'command': 'perl', 'cmdopt': '-MProject::Libs'}
NeoBundleLazy 'briancollins/vim-jst',     {
            \ 'autoload': {'filetypes': ['jst', 'ejs']},
            \ 'depends': 'pangloss/vim-javascript' }
"NeoBundleLazy 'yuku-t/vim-ref-ri', {
"            \ 'depends': ['Shougo/unite.vim', 'thinca/vim-ref'],
"            \ 'autoload': { 'filetypes': ['ruby', 'eruby', 'haml'] } }

NeoBundleLazy 'leafgarland/typescript-vim', {'autoload': {'filetypes': ['typescript']}}

NeoBundle 'tpope/vim-rails'
"NeoBundle 'dbext.vim'

NeoBundleLazy 'thoughtbot/vim-rspec', {
            \ 'autoload' : { 'filetypes' : ['ruby'] },
            \ 'depends'  : 'tpope/vim-dispatch' }
let s:bundle = neobundle#get('vim-rspec')
function! s:bundle.hooks.on_source(bundle)
   let g:rspec_command = 'Dispatch rspec {spec}'
endfunction

"" Colorize
NeoBundle 'chriskempson/base16-vim'
colorscheme base16-default
set background=dark

filetype plugin indent on

" Installation check
NeoBundleCheck


function! s:open_kobito(...)
    if a:0 == 0
        call system('open -a Kobito '.expand('%:p'))
    else
        call system('open -a Kobito '.join(a:000, ' '))
    endif
endfunction

command! -nargs=* Kobito call s:open_kobito(<f-args>)
command! -nargs=0 KobitoClose call system("osascript -e 'tell application \"Kobito\" to quit'")
command! -nargs=0 KobitoFocus call system("osascript -e 'tell application \"Kobito\" to activate'")

if exists("$HOME/.vimrc.local")
    source $HOME/.vimrc.local
endif

" vim: set filetype=vim :

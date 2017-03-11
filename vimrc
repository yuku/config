" {{{1 General
set nocompatible            " Use Vim in more useful way
filetype on                 " Enable filetype detection
filetype indent on          " Enable filetype-specific indenting
filetype plugin on          " Enable filetype-specific plugins
set clipboard+=unnamed      " share clipboard with other systems
set helplang=ja,en          " search ja help docs if exists

inoremap # X<BS>#
set shiftround
set virtualedit=block       " allow virtual edit in visual block ..
set ambiwidth=double

set autoread                " prevent W11 warning
" http://vim-jp.org/vim-users-jp/2011/03/12/Hack-206.html
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

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
if !filewritable($HOME."/.vim/backup")
  call mkdir($HOME."/.vim/backup", "p")
endif
set backupdir=$HOME/.vim/backup
if !filewritable($HOME."/.vim/swap")
  call mkdir($HOME."/.vim/swap", "p")
endif
set directory=$HOME/.vim/swap

"" Persistent undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

" {{{1 UI
syntax on

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
  set colorcolumn=125
  execute "set colorcolumn=" . join(range(126, 999), ',')
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

" {{{1 Search
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

" {{{1 Abbreviations
ab organizaiton organization
ab organiztion organization
ab Organizaiton Organization
ab Organiztion Organization
ab calss class

" {{{1 Behavior
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

" {{{1 ftdetects
augroup MyFileTypeDetect
    au!
    au BufRead,BufNewFile Capfile,Gemfile,*.cap,*.god set filetype=ruby
    " au BufRead,BufNewFile *.md                  set filetype=markdown
    au BufRead,BufNewFile *.PL,*.psgi,*.t       set filetype=perl
    " au BufRead,BufNewFile .tmux.conf,tmux.conf  set filetype=tmux
    au BufRead,BufNewFile *.jade                set filetype=jade
    au BufRead,BufNewFile *.less                set filetype=less
    au BufRead,BufNewFile *.coffee              set filetype=coffee
    au BufRead,BufNewFile *.hatena              set filetype=hatena
    au BufRead,BufNewFile *.pp                  set filetype=puppet
    au BufRead,BufNewFile *.scss                set filetype=scss
    " au BufRead,BufNewFile *.ts                  set filetype=typescript
    au BufRead,BufNewFile *.peg                 set filetype=pegjs
    " au BufRead,BufNewFile *.rb                  set syntax=yard
    au BufNewFile,BufRead *.ejs                 set filetype=jst
    au BufNewFile,BufRead *.jst                 set filetype=jst
    au BufNewFile,BufRead *.djs                 set filetype=jst
    au BufNewFile,BufRead *.hamljs              set filetype=jst
    au BufNewFile,BufRead *.ect                 set filetype=jst
augroup END


"" Golang
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

" augroup MyGolangConfig
"     au!
"     au BufNewFile *.go setlocal filetype=go fileencoding=utf-8 fileformat=unix
"     au BufRead *.go call s:gofiletype_pre()
"     au BufReadPost *.go call s:gofiletype_post()
" augroup END

" {{{1 Highlight
augroup whitespace
    autocmd!
    autocmd VimEnter,WinEnter ruby,javascript,coffee match WhitespaceEOL /\s\+$/
augroup END
highlight WhitespaceEOL ctermbg=red guibg=red
highlight CursorLineNr ctermfg=DarkYellow guifg=DarkYellow
"highlight Comment ctermfg=DarkCyan guifg=DarkCyan

" {{{1 Key mappings
let mapleader=','           " Lead with ,

" Jump to vimrc
nnoremap <space>v :<C-u>edit $DOTFILES_ROOT/vimrc<CR>
" Reload vimrc setting
nnoremap <space>s :<C-u>source $HOME/.vimrc<CR>
" Create new tab
cnoremap <C-t> <C-u>tabnew<CR>
nnoremap <C-h> :<C-u>tabprevious<CR>
nnoremap <C-l> :<C-u>tabnext<CR>
" Recall command-line from history, whose beginning matches the current command-line.
cnoremap <C-p> <UP>
cnoremap <C-n> <DOWN>
" Expand %% as %:h
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Move to n-th tab by Cmd-n
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

" {{{1 Plugins
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'Lokaltog/vim-easymotion'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/unite.vim' | Plug 'Shougo/neomru.vim' | Plug 'Shougo/unite-outline'
Plug 'Shougo/vimfiler'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/vimshell'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
Plug 'airblade/vim-gitgutter'
Plug 'briancollins/vim-jst', { 'for': 'jst' }
Plug 'chriskempson/base16-vim'
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go'
Plug 'flowtype/vim-flow', { 'for': 'javascript.jsx' }
Plug 'itchyny/lightline.vim'
" Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user' | Plug 'rhysd/vim-textobj-ruby', { 'for': 'ruby' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'noprompt/vim-yardoc', { 'for': 'ruby' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
" Plug 'rhysd/clever-f.vim'
Plug 'scrooloose/syntastic'
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'tpope/vim-abolish'
" Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'tpope/vim-rails'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-ruby/vim-ruby'

" Add plugins to &runtimepath
call plug#end()

" {{{2 YouCompleteMe
let g:ycm_collect_identifiers_from_tags_files = 1

" {{{2 lightline
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
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag'
      \ },
      \ }

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

" {{{2 neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

" {{{2 syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_scss_checkers = ['stylelint']
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']

let g:syntastic_mode_map = { 'mode': 'active',
      \ 'passive_filetypes': ['go', 'html', 'python'] }

" {{{2 ultisnips
let g:UltiSnipsExpandTrigger = '<c-e>'
" let g:UltiSnipsListSnippets = '<c-l>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

" {{{2 unite
" The prefix key.
nnoremap [unite]  <Nop>
nmap     <space>  [unite]

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

call unite#custom#source('file_rec/git,file_rec/async',
      \ 'ignore_pattern', '\.\(gif\|jpeg\?\|png\|webp\)$')

call unite#custom#source('neomru/file', 'matchers', ['matcher_project_files', 'matcher_fuzzy'])

function! DispatchUniteFileRecAsyncOrGit()
  if isdirectory(getcwd()."/.git")
    " If current dir is root git directory.
    Unite -profile-name=ctrlp file_rec/git
  else
    Unite -profile-name=ctrlp file_rec/async:!
  endif
endfunction
nnoremap <silent> <C-p> :<C-u>call DispatchUniteFileRecAsyncOrGit()<CR>

nnoremap <silent> [unite]m :<C-u>Unite -profile-name=ctrlp neomru/file<CR>
nnoremap <silent> [unite]u :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> [unite]c :<C-u>UniteWithCurrentDir -buffer-name=files buffer bookmark<CR>
nnoremap <silent> [unite]/ :<C-u>Unite grep:.<CR>
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
"  autocmd FileType vim    nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit help<CR>
"  autocmd FileType sh     nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/man<CR>
"  autocmd FileType erlang nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/erlang<CR>
"  autocmd FileType ruby   nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/ri<CR>
"  autocmd FileType python nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/pydoc<CR>
"  autocmd FileType perl   nnoremap <silent><buffer> K :<C-u>Unite -start-insert -default-action=vsplit ref/perldoc<CR>
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

let g:unite_source_grep_max_candidates = 200

if executable('hw')
  let g:unite_source_grep_command = 'hw'
  let g:unite_source_grep_default_opts = '--no-group --no-color'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('ag')
  " Use ag in unite grep source.
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" {{{2 vim-easymotion
let g:EasyMotion_mapping_j = '<C-j>'
let g:EasyMotion_mapping_k = '<C-k>'

" {{{2 vim-flow
let g:flow#autoclose = 1
let g:flow#enable = 1

" {{{2 vim-fugitive
nnoremap <silent>gs :<C-u>Gstatus<CR>

" {{{2 vim-go
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"

" {{{2 vim-javascript
let g:javascript_plugin_flow = 1

" {{{2 vim-jsx
let g:jsx_ext_required = 0

" {{{2 vim-plug
augroup MyVimPlugSettings
    autocmd!
    autocmd FileType vim-plug setlocal nonumber
augroup END

" {{{2 vimfiler
" Replace netrw function with vimfiler
let g:vimfiler_as_default_explorer = 1

let g:vimfiler_enable_auto_cd = 1

let s:blacklist = ['gitcommit', 'gitrebase']
let s:min_width = 120

function! s:vimfiler_my_settings()
  nmap <silent><buffer><C-i>       <Plug>(vimfiler_split_edit_file)
  nmap <silent><buffer><CR>        <Plug>(vimfiler_expand_or_edit)
  nmap <silent><buffer><expr><C-k> vimfiler#do_switch_action('split')

  " move/copy/delete cursor file in one key.
  nmap <buffer>c <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_copy_file)
  nmap <buffer>m <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_move_file)
  nmap <buffer>d <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_delete_file)

  setlocal nonumber
endfunction

nnoremap <silent> [unite]e :<C-u>VimFilerExplorer -no-focus -toggle -buffer-name=filer -winwidth=40<CR>

augroup MyVimFilerSettings
    autocmd!
    autocmd FileType vimfiler call s:vimfiler_my_settings()
    "autocmd VimEnter * if index(s:blacklist, &ft) < 0 && winwidth(0) >= s:min_width | execute "normal [unite]e" | endif
    "autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
augroup END

" {{{2 vimshell
augroup MyVimShellSettings
    autocmd!
    autocmd FileType vimshell setlocal nonumber
augroup END

" {{{1
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

if filereadable("$HOME/.vimrc.local")
  source $HOME/.vimrc.local
endif

" vim:set foldmethod=marker:

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
Plug 'Shougo/neco-vim'
Plug 'Shougo/neosnippet' | Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/unite.vim' | Plug 'Shougo/neomru.vim' | Plug 'Shougo/unite-outline'
Plug 'Shougo/vimfiler'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/vimshell'
Plug 'airblade/vim-gitgutter'
Plug 'briancollins/vim-jst', { 'for': 'jst' }
Plug 'chriskempson/base16-vim'
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'flowtype/vim-flow', { 'for': 'javascript' }
Plug 'kana/vim-textobj-user' | Plug 'rhysd/vim-textobj-ruby', { 'for': 'ruby' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'noprompt/vim-yardoc', { 'for': 'ruby' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' } | Plug 'maxmellon/vim-jsx-pretty', { 'for': 'javascript' }
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'tpope/vim-rails'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'w0rp/ale'
Plug 'wokalski/autocomplete-flow'
Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go' }

" Add plugins to &runtimepath
call plug#end()

" {{{2 base16
let base16colorspace=256
colorscheme base16-default-dark


" {{{2 deoplate.nvim
let g:deoplete#enable_at_startup = 1

" {{{2 neosnippet
let g:neosnippet#enable_completed_snippet = 1

imap <C-e> <Plug>(neosnippet_expand_or_jump)
smap <C-e> <Plug>(neosnippet_expand_or_jump)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
xmap <C-e> <Plug>(neosnippet_expand_jump)

if has("conceal")
  set conceallevel=2 concealcursor=niv
endif

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

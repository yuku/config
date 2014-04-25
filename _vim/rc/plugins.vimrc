filetype off
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', { 'build': {
                \ 'windows' : 'make -f make_wingw32.mak',
                \ 'cygwin'  : 'make -f make_cygwin.mak',
                \ 'mac'     : 'make -f make_mac.mak',
                \ 'unix'    : 'make -f make_unix.mak'
            \ } }

NeoBundle 'Shougo/unite.vim' " {{{
"NeoBundle 'yuku-t/unite-git'
NeoBundle 'Shougo/unite-outline'
"NeoBundle 'Shougo/unite-help'
"NeoBundle 'joker1007/unite-pull-request', { 'depends': 'mattn/webapi-vim' }
"let g:unite_enable_split_vertically = 1
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif
let g:unite_winwidth = 50
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
call unite#custom#source('file_rec/async', 'ignore_pattern', '\v/doc/|\.git/|/cache/|\.(png|gif|jpeg|jpg)$')
call unite#custom#source('file_mru', 'ignore_pattern', '.*\/$\|.*Application\ Data.*')

" The prefix key.
nnoremap [unite]  <Nop>
nmap     <space>  [unite]

nnoremap <silent> <C-p>    :<C-u>Unite file_rec/async:!<CR>
nnoremap <silent> [unite]u :<C-u>UniteWithBufferDir file file/new<CR>
nnoremap <silent> [unite]/ :<C-u>Unite grep:.<CR>
nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]b :<C-u>Unite -quick-match buffer<CR>
"nnoremap <silent> [unite]h :<C-u>Unite help<CR>
nnoremap <silent> [unite]t :<C-u>Unite -no-start-insert tab:no-current<CR>
nnoremap <silent> [unite]w :<C-u>Unite -no-start-insert window:no-current<CR>
"nnoremap <silent> [unite]m :<C-u>Unite git_modified<CR>
nnoremap <silent> [unite]a :<C-u>Unite -vertical -no-quit -no-focus -no-start-insert -toggle -direction=topleft -buffer-name=async -winwidth=30 file_rec/async<CR>
nnoremap <silent> [unite]o :<C-u>Unite -vertical -no-quit -toggle -direction=botright -buffer-name=outline -winwidth=40 outline<CR>
"
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
" }}}

if has('lua')
    NeoBundle 'Shougo/neocomplete' " {{{
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Use camel case completion.
    let g:neocomplete#enable_camel_case = 1
    " Supress some errors.
    let g:neocomplete#force_overwrite_completefunc = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
    " The number of candidates displayed in a pop-up menu.
    let g:neocomplete#max_list = 10

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
                \ 'default'    : '',
                \ 'perl'       : $HOME.'/.vim/dict/perl.dict',
                \ 'javascript' : $HOME.'/.vim/dict/javascript.dict',
                \ 'coffee'     : $HOME.'/.vim/dict/javascript.dict',
                \ 'gitcommit'  : $HOME.'/.vim/dict/gitcommit.dict'
                \ }

    " Define keyword.
    if !exists('g:neocomplete_keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>  neocomplete#undo_completion()
    "inoremap <expr><C-l>  neobundle#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return neocomplete#smart_close_popup() . "\<CR>"
        " For no inserting <CR> key.
        "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: compleion.
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y> neocomplete#close_popup()
    inoremap <expr><C-e> neocomplete#cancel_popup()
    " <Space>: close popup.
    "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

    " Enable omni completion.
    augroup OmniCompletion
        autocmd!
        autocmd FileType css
              \ setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown,slim
              \ setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript
              \ setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python
              \ setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml
              \ setlocal omnifunc=xmlcomplete#CompleteTags
    augroup END
    " Ruby omni completion.
    NeoBundle 'supermomonga/neocomplete-rsense.vim'
    " }}}

    NeoBundle 'Shougo/neosnippet' " {{{
    let g:neosnippet#snippets_directory =
          \ '~/.vim/snippets,~/.vim/bundle/snipmate-snippets/snippets'

    " Key mapping.
    inoremap <C-k>        <Plug>(neosnippet_expand_or_jump)
    snoremap <C-k>        <Plug>(neosnippet_expand_or_jump)
    xnoremap <C-k>        <Plug>(neosnippet_expand_target)
    xnoremap <C-l>        <Plug>(neosnippet_start_unite_snippet_target)

    " For snippet_complete marker.
    if has('conceal')
        set conceallevel=2 concealcursor=i
    endif

    " }}}
else
    NeoBundle 'Shougo/neocomplcache'
endif

NeoBundle 'Shougo/vimfiler', {'depends': 'Shougo/unite.vim'} " {{{
" Use vimfiler as file manager instead of netrw.
let g:vimfiler_as_default_explorer = 1
" Edit file by tabedit.
"let g:vimfiler_edit_action = 'tabopen'
" Enable file operation commands.
let g:vimfiler_safe_mode_by_default = 0
" Use with powerline
let g:vimfiler_force_overwrite_statusline = 0

nnoremap <silent><space>e :<C-u>VimFilerCurrentDir -explorer -find -split 
      \ -simple -winwidth=30 -toggle -no-quit<CR>

augroup VimFilerSettings
    autocmd!
    autocmd FileType vimfiler nnoremap <buffer> <C-j>
          \ :<C-u>call EasyMotion#JK(0, 0)<CR>
    autocmd FileType vimfiler nmap <buffer> <2-LeftMouse>
          \ <Plug>(vimfiler_edit_file)
    " Starts VimFiler automatically if no files were specified.
    if !argc()
        autocmd VimEnter * VimFiler -status
    endif
augroup END
" }}}

"NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-localrc'

"NeoBundle 'airblade/vim-gitgutter'
"let g:gitgutter_enabled = 0
"let g:gitgutter_eager = 0
"nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
"nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>
"NeoBundle 'gregsexton/gitv'
"augroup Gitv
"    autocmd!
"    autocmd FileType gitv call s:my_gitv_settings()
"    autocmd FileType git setlocal nofoldenable foldlevel=0
"augroup END
"function! s:gitv_get_current_hash()
"    return matchstr(getline('.'), '\[\zs.\{7\}\ze\]$')
"endfunction
"function! s:toggle_gitv_folding()
"    if &filetype ==# 'git'
"        setlocal foldenable!
"    endif
"endfunction
"function! s:my_gitv_settings()
"    setlocal iskeyword+=/,-,.
"    nnoremap <silent><buffer> C :<C-u>Git checkout <C-r><C-w><CR>
"    nnoremap <buffer> <Space>rb :<C-u>Git rebase <C-r>=<SID>gitv_get_current_hash()<CR><Space>
"    nnoremap <buffer> <Space>R :<C-u>Git revert <C-r>=<SID>gitv_get_current_hash()<CR><CR>
"    nnoremap <buffer> <Space>h :<C-u>Git cherry-pick <C-r>=<SID>gitv_get_current_hash()<CR><CR>
"    nnoremap <buffer> <Space>rh :<C-u>Git reset --hard <C-r>=<SID>gitv_get_current_hash()<CR>
"    nnoremap <buffer> G :<C-u>Gbrowse <C-r>=<SID>gitv_get_current_hash()<CR><CR>
"    nnoremap <silent><buffer> t :<C-u>windo call <SID>toggle_gitv_folding()<CR>1<C-w>w
"endfunction
"
"NeoBundle 'nathanaelkane/vim-indent-guides'
"let g:indent_guides_auto_colors = 1 " read help txt
"let g:indent_guides_enable_on_vim_startup = 1
""let g:indent_guides_start_level = 1
"let g:indent_guides_guide_size = 0
"let g:indent_guides_color_change_percent = 10
"let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

NeoBundle 'Lokaltog/vim-easymotion'
let g:EasyMotion_mapping_j = '<C-j>'
let g:EasyMotion_mapping_k = '<C-k>'

NeoBundle 'scrooloose/syntastic'
let g:syntastic_mode_map = {
            \ 'mode': 'passive',
            \ 'active_filetypes': ['javascript', 'python', 'perl'],
            \ 'passive_filetypes': []
            \ }
let g:syntastic_ruby_checkers = ['rubocop']
"let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_javascript_checkers = ['jshint']

"NeoBundle 'goldfeld/vim-seek'
"NeoBundle "Align"
"
NeoBundleLazy 'tpope/vim-markdown',
            \ {'autoload': {'filetypes': ['markdown']}}
NeoBundleLazy 'cakebaker/scss-syntax.vim',
            \ {'autoload': {'filetypes': ['scss']}}
NeoBundleLazy 'mattn/zencoding-vim',
            \ {'autoload': {'filetypes': ['html', 'eruby']}}
NeoBundleLazy 'othree/html5.vim',
            \ {'autoload': {'filetypes': ['html']}}
NeoBundleLazy 'digitaltoad/vim-jade',
            \ {'autoload': {'filetypes': ['jade']}}
NeoBundleLazy 'groenewege/vim-less',
            \ {'autoload': {'filetypes': ['less']}}
NeoBundleLazy 'petdance/vim-perl',
            \ {'autoload': {'filetypes': ['perl']}}
NeoBundleLazy 'kchmck/vim-coffee-script',
            \ {'autoload': {'filetypes': ['coffee']}}
augroup CoffeeScript
    autocmd!
    autocmd FileType coffee call s:my_coffee_settings()
augroup END
function! s:my_coffee_settings()
    nnoremap <silent><buffer> <leader>c :<C-u>CoffeeWatch vertical<CR>
    vnoremap <silent><buffer> <leader>c :<C-u>'<,'>CoffeeCompile vertical<CR>
endfunction
NeoBundleLazy 'motemen/xslate-vim', {
            \ 'autoload': {'filetypes': ['xslate']}
            \ }
NeoBundleLazy 'motemen/hatena-vim', {
            \ 'autoload': {'filetypes': ['hatena']}
            \ }
NeoBundleLazy 'nginx.vim', {
            \ 'autoload': {'filetypes': ['nginx']}
            \ }
NeoBundleLazy 'rodjek/vim-puppet', {
            \ 'autoload': {'filetypes': ['puppet']}
            \ }
NeoBundleLazy 'vim-ruby/vim-ruby', {
            \ 'autoload': {'filetypes': ['ruby', 'eruby', 'haml']}
            \ }
NeoBundleLazy 'skwp/vim-rspec', {
            \ 'autoload': {'filetypes': ['ruby']}
            \ }
NeoBundleLazy 'ruby-matchit', {
            \ 'autoload': {'filetypes': ['ruby', 'eruby', 'haml']}
            \ }
NeoBundleLazy 'pangloss/vim-javascript', {
            \ 'autoload': {'filetypes': ['javascript']}
            \ }
NeoBundleLazy 'briancollins/vim-jst', {
            \ 'autoload': {'filetypes': ['jst', 'ejs']},
            \ 'depends': 'pangloss/vim-javascript'
            \ }
NeoBundleLazy 'leafgarland/typescript-vim',
            \ {'autoload': {'filetypes': ['typescript']}
            \ }
NeoBundleLazy 'slim-template/vim-slim', {
            \ 'autoload': {'filetypes': ['slim']}
            \ }
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
NeoBundleLazy 'thoughtbot/vim-rspec', {
            \ 'autoload' : { 'filetypes' : ['ruby'] },
            \ 'depends'  : 'tpope/vim-dispatch'
            \ }
let s:bundle = neobundle#get('vim-rspec')
function! s:bundle.hooks.on_source(bundle)
   let g:rspec_command = 'Dispatch rspec {spec}'
endfunction
"NeoBundleLazy 'thinca/vim-quickrun',      {'autoload': {'filetypes': ['ruby', 'python', 'perl', 'sh']}}
"nmap <Leader>r <plug>(quickrun)
"let g:quickrun_config = {}
"let g:quickrun_config.perl = {'command': 'perl', 'cmdopt': '-MProject::Libs'}
""NeoBundleLazy 'yuku-t/vim-ref-ri', {
""            \ 'depends': ['Shougo/unite.vim', 'thinca/vim-ref'],
""            \ 'autoload': { 'filetypes': ['ruby', 'eruby', 'haml'] } }

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-rails'
"NeoBundle 'dbext.vim'
"

"" Colorize
NeoBundle 'chriskempson/base16-vim'
colorscheme base16-default
set background=dark

NeoBundle 'itchyny/lightline.vim' " {{{
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
            \ 'component_expand': {
            \   'syntastic': 'SyntasticStatuslineFlag'
            \ },
            \ 'component_type': {
            \   'syntastic': 'error'
            \ }
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

augroup AutoSyntastic
    au!
    au BufWritePost *.rb,*.js call s:syntastic()
augroup END
function! s:syntastic()
    SyntasticCheck
    call lightline#update()
endfunction
" }}}

filetype plugin indent on

" Installation check
NeoBundleCheck

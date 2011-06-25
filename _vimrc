"-----------------------------------------------------
" 基本的な設定
"-----------------------------------------------------
" viとの互換性をとらない(vimの拡張機能を使うため）
set nocompatible
" 改行コードの自動認識
set fileformats=unix,dos,mac
" ビープ音を鳴らさない
set vb t_vb=
" バックスペースで削除できるものを指定
set backspace=indent,eol,start
"" Leader
let mapleader=","
" Path
let path = "~/my_settings"
" 8進数を10進数として扱う
set nrformats-=octal
" マウスを使える場合はvim内で使用可能にする
if has("mouse")
    set mouse=a
endif
" クリップボードから貼付け
map <space>p "+gP

"-----------------------------------------------------
" vimrc関連
"-----------------------------------------------------
" vimrcへのホットキー
nnoremap <space><space> :<C-u>edit $MYVIMRC<CR>
" vimrcをリロード
nnoremap <space>s :<C-u>source $MYVIMRC<CR>

"-----------------------------------------------------
" ファイル操作関連
"-----------------------------------------------------
" Exploreでカレントディレクトリを開く
set browsedir=current

"-----------------------------------------------------
" バックアップ関連
"-----------------------------------------------------
" バックアップをとる
set backup
if !filewritable($HOME."/.vim-backup")
    call mkdir($HOME."/.vim-backup", "p")
endif
set backupdir=$HOME/.vim-backup
set directory=$HOME/.vim-swap
"let &directory = &backup dir
" ファイルの上書き前にバックアップ作成。成功したら削除
set writebackup

"-----------------------------------------------------
" 検索関係
"-----------------------------------------------------
" コマンド、検索パターンを100個まで履歴に残す
set history=100
" 検索の時に大文字小文字を区別しない
set ignorecase
" 検索の時に大文字が含まれている場合は区別して検索する
set smartcase
" 最後まで検索したら先頭に戻らない
set nowrapscan
" インクリメンタルサーチを使う
set incsearch

"-----------------------------------------------------
" 表示関係
"-----------------------------------------------------
" タイトルをウィンドウ枠に表示する
set title
" 行番号を表示する
set number
" ルーラーを表示
set ruler
" 入力中のコマンドをステータスに表示する
set showcmd
" ステータスラインを常に表示
set laststatus=2
" 括弧入力時に対応する括弧を表示
set showmatch
" 対応する括弧の表示時間を3にする
set matchtime=3
" シンタックスハイライトを有効にする
syntax on
" 検索結果文字列のハイライトを有効にする
set hlsearch
" 行末の空白をハイライト
highlight WhitespaceEOL ctermbg=red guibg=red
matc WhitespaceEOL /\s\+$/
"autocmd WinEnter * match WhitespaceEOL /\s\+$/
" コメントの色を変更
highlight Comment ctermfg=DarkCyan
" コマンドライン補完を拡張モードにする
set wildmenu
" 行末から次の行へ移るようにする
set whichwrap=b,s,h,l,<,>,[,]
" 入力されているテキストの最大幅を無効にする
set textwidth=0
" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap
" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
matc ZenkakuSpace /　/
" ステータスラインに表示する情報の指定
set statusline=%n\:%y%F\ %{fugitive#statusline()}\|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=%c\:%l/%L\|%P\|
" ステータスラインの色
highlight StatusLine term=NONE cterm=NONE ctermfg=black ctermbg=white
" カーソル行を表示
set cursorline
set ruler
set nostartofline
set virtualedit=block

"-----------------------------------------------------
" ウィンドウ
"-----------------------------------------------------
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l
imap <C-w> <C-o><C-w>

"-----------------------------------------------------
" タブ
"-----------------------------------------------------
" タブが対応する空白の数
set tabstop=4
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=4
" インデントの各段階に使われる空白の数
set shiftwidth=4
" タブを挿入するとき、代わりに空白を使う
set expandtab
" インデントをオプションの'shiftwidth'の値の倍数に丸める
set shiftround

"-----------------------------------------------------
" インデント
"-----------------------------------------------------
" オートインデントを有効にする
set autoindent
" 新しい行を作ったときに高度な自動インデントを行う。 'cindent'
" がオンのときは、'smartindent' をオンにしても効果はない。
set smartindent
" Cプログラムファイルの自動インデントを始める。
"set cindent

"----------------------------------------------------
"" 国際化関係
"----------------------------------------------------
" 文字コードの設定
" fileencodingsの設定ではencodingの値を一番最後に記述する
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

"----------------------------------------------------
" 移動
"----------------------------------------------------

imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap <> <><Left>
imap "" ""<Left>
imap '' ''<Left>

"----------------------------------------------------
" vim-tab
"----------------------------------------------------
"nnoremap <C-k> :Texplore<Return>
"nnoremap <C-l> :tabnext<Return>
"nnoremap <C-h> :tabprevious<Return>

set clipboard=unnamed

"-----------------------------------------------------
" プラグイン
"-----------------------------------------------------
filetype off
set rtp+=~/.vim/vundle.git/
call vundle#rc()

" YankRing
Bundle 'YankRing.vim'
nnoremap <silent> <F1> :YRShow<CR>
let g:yankring_history_file='.yankring_history'

" Syntax highlight
Bundle 'cucumber.zip'
Bundle 'Markdown'

" Git integration
Bundle 'git.zip'
Bundle 'fugitive.vim'
Bundle 'unimpaired.vim'

" FuzzyFinder
Bundle 'L9'
Bundle 'FuzzyFinder'
let g:fuf_mrufile_exclude = '\v\.DS_Store|\.git|\.swp|\.svn'
let g:fuf_file_exclude = '\v\.DS_Store|\.git|\.swp|\.svn'
let g:fuf_modesDisable = []
nnoremap <space>b  :FufBuffer!<CR>
nnoremap <space>f  :FufFile!<CR>

" surround
Bundle 'surround.vim'
let g:surround_{char2nr("*")} = "/* \r */"
let g:surround_{char2nr("p")} = "<?php \r ?>"

" quick run
Bundle 'quickrun.vim'
nmap <space>r <plug>(quickrun)

" NERD Commenter
Bundle 'The-NERD-Commenter'
vmap <space>c <plug>NERDCommenterToggle

" TaskList
Bundle 'TaskList.vim'

" pydoc.vim
Bundle 'pydoc.vim'

" taglist.vim
Bundle 'taglist.vim'

" neocomplcache
Bundle 'neocomplcache'
let g:neocomplcache_enable_at_startup = 1

filetype plugin indent on

"-----------------------------------------------------
" 
"-----------------------------------------------------
if !exists("rtrim")
    function! RTrim()
        let s:cursor = getpos(".")
        %s/\s\+$//e
        call setpos(".", s:cursor)
    endfunction
    
    autocmd BufWritePre *.{py,java,rb,js,php,pl,js,html,css} call RTrim()
endif

"-----------------------------------------------------
" local settings
"-----------------------------------------------------
if filereadable(expand('~/.vimrc.mine'))
    source ~/.vimrc.mine
endif

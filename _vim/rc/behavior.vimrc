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
set textwidth=79            " wrap at 79 chars by default
" Enable all keys to move the cursor left/right to the previous/next line
set whichwrap=b,s,h,l,<,>,[,]
" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
set nostartofline           " don't jump to the start of line when scrolling
set wildmenu                " turn on wild menu
set wildmode=list:longest,full

" Treat octal and hexadecimal number as decimal number
" octal  Numbers that start with a zero will be considered to be octal
"        Example: Using CTRL-A on "007" results in "010"
" hex    Numbers starting with "0x" or "0X" will be considered to be hexadecimal
"        Example: Using CTRL-X on "0x100" results in "0x0ff"
set nrformats+=octal,hex

augroup FileTypePlugin
    au!
    au FileType css        setlocal ts=4 sts=4 sw=4
    au FileType gitcommit  setlocal ts=4 sts=4 sw=4 textwidth=69
    au FileType htmldjango setlocal ts=4 sts=4 sw=4
    au FileType html       setlocal ts=4 sts=4 sw=4
    au FileType int-gosh   setlocal nonu
    au FileType int-pry    setlocal nonu
    au FileType int-python setlocal nonu
    au FileType java       setlocal ts=4 sts=4 sw=4
    au FileType markdown   setlocal ts=4 sts=4 sw=4
    au FileType perl       setlocal ts=4 sts=4 sw=4
    au FileType python     setlocal ts=4 sts=4 sw=4 si cinw=if,elif,else,for,while,try,except,finally,def,class
    au FileType rst        setlocal tw=0
    au FileType scss       setlocal ts=4 sts=4 sw=4
    au FileType javascript setlocal ts=2 sts=2 sw=2
    au FileType typescript setlocal ts=4 sts=4 sw=4
    au FileType vim        setlocal ts=4 sts=4 sw=4
    au FileType vimfiler   setlocal nonu
    au FileType vimshell   setlocal nonu
    au FileType zsh        setlocal ts=4 sts=4 sw=4
augroup END

augroup whitespace
    autocmd!
    autocmd VimEnter,WinEnter * match WhitespaceEOL /\s\+$/
augroup END
highlight WhitespaceEOL ctermbg=red guibg=red
highlight CursorLineNr ctermfg=DarkYellow guifg=DarkYellow
"highlight Comment ctermfg=DarkCyan guifg=DarkCyan

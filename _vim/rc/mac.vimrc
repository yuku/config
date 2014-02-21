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

"" ftdetects
augroup MyFileTypeDetect
    au!
    au BufRead,BufNewFile Capfile,Gemfile,*.cap,*.god set filetype=ruby
    au BufRead,BufNewFile *.json                set filetype=javascript
    au BufRead,BufNewFile *.md                  set filetype=markdown
    au BufRead,BufNewFile *.PL,*.psgi,*.t       set filetype=perl
    au BufRead,BufNewFile .tmux.conf,tmux.conf  set filetype=tmux
    au BufRead,BufNewFile *.jade                set filetype=jade
    au BufRead,BufNewFile *.less                set filetype=less
    au BufRead,BufNewFile *.coffee              set filetype=coffee
    au BufRead,BufNewFile *.hatena              set filetype=hatena
    au BufRead,BufNewFile *.pp                  set filetype=puppet
    au BufRead,BufNewFile *.scss                set filetype=scss
    au BufRead,BufNewFile *.ts                  set filetype=typescript
augroup END


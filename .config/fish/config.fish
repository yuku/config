set DOTFILES_ROOT (ghq root)/github.com/yuku/dotfiles
set PATH $DOTFILES_ROOT/bin $PATH

if status --is-interactive
  set BASE16_SHELL "$DOTFILES_ROOT/modules/base16-shell"
  source "$BASE16_SHELL/profile_helper.fish"

  if not test -e ~/.base16_theme
    base16-default-dark
  end

  eval (direnv hook fish)
end

if test -e ~/.local/share/fish/config.fish
  source ~/.local/share/fish/config.fish
end
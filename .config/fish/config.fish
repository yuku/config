set DOTFILES_ROOT (ghq root)/github.com/yuku/dotfiles

if status --is-interactive
  set BASE16_SHELL "$DOTFILES_ROOT/modules/base16-shell"
  source "$BASE16_SHELL/profile_helper.fish"

  if not test -e ~/.base16_theme
    base16-default-dark
  end

  # rbenv
  source (rbenv init -|psub)
end

# nodebrew
set PATH $HOME/.nodebrew/current/bin $PATH

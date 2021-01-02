# dotfiles

## Installation

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/yuku/config/master/etc/install)"
```

## Trouble shooting

### `zsh compinit: insecure directories`

Run `compaudit` then change the permission of listed directories:

```bash
compaudit
#=> There are insecure directories:
#=> /usr/local/share/zsh/site-functions
#=> /usr/local/share/zsh
chmod 755 /usr/local/share/zsh/site-functions
chmod 755 /usr/local/share/zsh
```

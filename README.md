# dotfiles

## Installation

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/yuku/config/master/etc/install)"
```

## Setup

### Touch ID in Terminal.app

To use touch ID from terminal.app, `sudo vim /etc/pam.d/sudo` then insert following lines:

```diff
  # sudo: auth account password session
+ auth       optional       /opt/homebrew/lib/pam/pam_reattach.so
+ auth       sufficient     pam_tid.so
  auth       sufficient     pam_smartcard.so
  auth       required       pam_opendirectory.so
  account    required       pam_permit.so
  password   required       pam_deny.so
  session    required       pam_permit.so
```

### Unlock SSH key

Do `ssh-keygen`, configure github, add following lines to `~/.ssh/config`:

```
Host *
   AddKeysToAgent yes
   UseKeychain yes
   IdentityFile ~/.ssh/id_rsa
```

then execute `ssh-add --apple-use-keychain ~/.ssh/id_rsa`.

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

### `E185: Cannot find color scheme 'base16-default-dark'`

Run `:PlugInstall` to install neovim plugins including `base16-default-dark`.

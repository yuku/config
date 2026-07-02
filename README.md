# dotfiles

## Installation

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/yuku/config/master/install.sh)"
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

### SSH key

```
ssh-keygen -t ed25519
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

## Trouble shooting

### Copilot

`:Copilot auth`

### VSCode devcontainer settings

Setting                   | Value
--------------------------|-----
Dotfiles: Install Command | *empty*
Dotfiles: Repository      | yuku/config
Dotfiles: Target Path     | ~/dev/src/github.com/yuku/config

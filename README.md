# dotfiles

## Installation

```bash
curl -fsSL https://raw.github.com/yuku-t/dotfiles/master/script/install.sh | bash
```

## Sync

```bash
dotfiles-sync
```

## Use eclim

### Build and setup

```bash
cd $DOTFILES_ROOT/modules/eclim
eclipse_app=/path/to/Eclipse.app
ant -Declipse.home=$eclipse_app/Contents/Eclipse
```

Install ruby development tool:

```bash
$eclipse_app/Contents/MacOS/eclipse \
  -clean -purgeHistory \
  -noSplash \
  -application org.eclipse.equinox.p2.director \
  -repository http://download.eclipse.org/releases/mars \
  -installIUs org.eclipse.dltk.ruby.feature.group \
  -vmargs -Declipse.p2.mirrors=true
```

### Run eclimd

```bash
$eclipse_app/Contents/Eclipse/eclimd
```

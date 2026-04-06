# .dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Requirements

```bash
# Arch
sudo pacman -Sy stow

# macOS
brew install stow
```

## Install

Clone the repo into your home directory and run stow from inside it:

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
stow .
```

Stow will create symlinks for every file/directory, mirroring the repo structure into `$HOME`.

## Uninstall

Remove all symlinks created by stow:

```bash
cd ~/dotfiles
stow -D .
```

## Dry run

Preview what stow would do without making any changes:

```bash
cd ~/dotfiles
stow -n -v .
```

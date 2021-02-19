#!/bin/sh
set -x

# Install brew
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
# brew tap homebrew/bundle
brew bundle

# Install ohmyz.sh
if test ! $(which brew); then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Removes .zshrc from ${HOME} (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf ${HOME}/.zshrc
ln -s $(pwd)/.zshrc ${HOME}/.zshrc

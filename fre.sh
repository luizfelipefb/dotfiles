#!/bin/sh

# Ask for the administrator password upfront
sudo -v

# Install brew
if test ! $(which brew); then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update Homebrew recipes
brew update

# Git
brew install git

# clone dotfiles
mkdir -p ${0}
git clone https://github.com/luizfelipefb/dotfiles/ ${0}

# Install all our dependencies with bundle (See Brewfile)
(cd ${0}; brew bundle;)

# Install ohmyz.sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Removes .zshrc from ${HOME} (if it exists) and symlinks the .zshrc file
rm -rf ${HOME}/.zshrc
(cd ${0}; ln -s $(pwd)/.zshrc ${HOME}/.zshrc;)

# Removes .gitignore_global from ${HOME} (if it exists) and symlinks the .gitignore_global file
rm -rf ${HOME}/.gitignore_global
(cd ${0}; ln -s $(pwd)/.gitignore_global ${HOME}/.gitignore_global;)

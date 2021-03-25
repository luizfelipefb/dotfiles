#!/bin/sh

local SAVE_PATH=$(realpath ${0})

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
mkdir -p ${SAVE_PATH}
git clone https://github.com/luizfelipefb/dotfiles/ ${SAVE_PATH}

# Install dependencies with bundle (See Brewfile)
brew bundle --file=${SAVE_PATH}/Brewfile

# Install ohmyz.sh
if test ! $(which omz); then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install spaceship theme
git clone https://github.com/denysdovhan/spaceship-prompt.git "${ZSH_CUSTOM}/themes/spaceship-prompt" --depth=1
ln -s "${ZSH_CUSTOM}/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM}/themes/spaceship.zsh-theme" 

# Install powerline font
git clone https://github.com/powerline/fonts.git /tmp/powerline
/tmp/powerline/install.sh

# Removes .zshrc from ${HOME} (if it exists) and symlinks the .zshrc file
rm -rf ${HOME}/.zshrc
ln -s "${SAVE_PATH}/.zshrc" "${HOME}/.zshrc"

# Removes .gitignore_global from ${HOME} (if it exists) and symlinks the .gitignore_global file
rm -rf ${HOME}/.gitignore_global
ln -s "${SAVE_PATH}/.gitignore_global" "${HOME}/.gitignore_global"

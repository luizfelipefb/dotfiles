#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Install brew
if test ! $(which brew); then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update Homebrew recipes
brew update

# Git
brew install git coreutils

# get full path
SAVE_PATH=$(realpath ${1})

# clone dotfiles
mkdir -p ${SAVE_PATH}
git clone https://github.com/luizfelipefb/dotfiles/ ${SAVE_PATH}

# Install dependencies with bundle (See Brewfile)
brew bundle --file=${SAVE_PATH}/Brewfile

# Install powerline font
git clone https://github.com/powerline/fonts.git /tmp/powerline
/tmp/powerline/install.sh

# Removes .zshrc from ${HOME} (if it exists) and symlinks the .zshrc file
rm -rf ${HOME}/.zshrc
ln -s "${SAVE_PATH}/dots/.zshrc" "${HOME}/.zshrc"

# Removes .gitignore_global from ${HOME} (if it exists) and symlinks the .gitignore_global file
rm -rf ${HOME}/.gitignore_global
ln -s "${SAVE_PATH}/dots/.gitignore_global" "${HOME}/.gitignore_global"

# Removes .alacritty.yml from ${HOME} (if it exists) and symlinks the .alacritty.yml file
rm -rf ${HOME}/.alacritty.yml
ln -s "${SAVE_PATH}/dots/.alacritty.yml" "${HOME}/.alacritty.yml"

# Removes settings.json from ${HOME}/.vscode (if it exists) and symlinks the settings.json file
mkdir -p "${HOME}/Library/Application Support/Code/User"
rm -rf "${HOME}/Library/Application Support/Code/User/settings.json"
ln -s "${SAVE_PATH}/dots/settings.json" "${HOME}/Library/Application Support/Code/User/settings.json"

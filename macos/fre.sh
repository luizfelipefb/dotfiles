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
SAVE_PATH=$(realpath .dotfiles)

# clone dotfiles
mkdir -p ${SAVE_PATH}
git clone https://github.com/luizfelipefb/dotfiles/ ${SAVE_PATH}

# Install dependencies with bundle (See Brewfile)
brew bundle --file=${SAVE_PATH}/macos/Brewfile

# Instal zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# export location variables
export ALACRITTY_CONFIG="$HOME/config/.alacritty.toml"
export VSCODE_CONFIG="$HOME/.config/Code/User/settings.json"

## RUN README.md instructions

# Update shell
source ~/.zshrc

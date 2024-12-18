# .dotfiles

Set OS env variables for the applications config locations and run the following script

```zsh
# .alacritty
ln -s $HOME/.dotfiles/alacritty/.alacritty.toml $HOME/.alacritty.toml

# .gitignore
git config --global core.excludesfile $HOME/git/.dotfiles/.gitignore

# k9s
. $HOME/.dotfiles/k9s/get-catppuccin-theme.sh
ln -s $HOME/.dotfiles/k9s/aliases.yaml $HOME/.config/k9s/aliases.yaml
ln -s $HOME/.dotfiles/k9s/config.yaml $HOME/.config/k9s/config.yaml

# starship
ln -s $HOME/.dotfiles/starship/starship.toml $HOME/.config/starship.toml

# vim
ln -s $HOME/.dotfiles/vim/.vimrc $HOME/.vimrc

# vscode
ln -s $HOME/.dotfiles/vscode/settings.json $HOME/.config/Code/User/settings.json

# .zshrc
ln -s $HOME/.dotfiles/zsh/.zshrc $HOME/.zshrc
```

# .dotfiles

Set OS env variables for the applications config locations and run the following script

```zsh
# .alacritty
ln -s "$HOME/.dotfiles/.alacritty.toml" $ALACRITTY_CONFIG

# .gitignore
git config --global core.excludesfile $HOME/.dotfiles/.gitignore

# .zshrc
ln -s "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"

# vscode
ln -s "$HOME/.dotfiles/settings.json" $VSCODE_CONFIG

# starship
ln -s "$HOME/.dotfiles/starship.toml" $HOME/.config/starship.toml
```

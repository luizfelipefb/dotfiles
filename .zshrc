# zplug
export ZPLUG_HOME=${HOME}/.zplug

source ${ZPLUG_HOME}/init.zsh

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh

zplug "zsh-users/zsh-completions", defer:0
zplug "zsh-users/zsh-autosuggestions", defer:2, on:"zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:3, on:"zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:3, on:"zsh-users/zsh-syntax-highlighting"

zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

# szsh tyle
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# dir colors
alias ls='gls --color=always'
alias l='ls -lah'

# brew paths
export PATH="/usr/local/sbin:${PATH}"

# asdf
source /usr/local/opt/asdf/asdf.sh

# current project
alias cdc='cd "${HOME}/Workspace/ab-inbev/iac-microservices"'


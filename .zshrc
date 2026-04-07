# configure key keybindings
bindkey -e                                     # emacs key bindings
bindkey ' ' magic-space                        # do history expansion on space
bindkey '^U' backward-kill-line                # ctrl + U
bindkey '^[[3;5~' kill-word                    # ctrl + Supr
bindkey '^[[3~' delete-char                    # delete
bindkey '^[[1;5C' forward-word                 # ctrl + ->
bindkey '^[[1;5D' backward-word                # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history # page up
bindkey '^[[6~' end-of-buffer-or-history       # page down
bindkey '^[[H' beginning-of-line               # home
bindkey '^[[F' end-of-line                     # end
bindkey '^[[Z' undo                            # shift + tab undo last action

# search with arrows up and down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# zhs style
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# History configurations
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  # change suggestion color
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# zplug
export ZPLUG_HOME=${HOME}/.zplug
source ${ZPLUG_HOME}/init.zsh

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/terraform", from:oh-my-zsh

zplug "zsh-users/zsh-completions", defer:0
zplug "zsh-users/zsh-autosuggestions", defer:2, on:"zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:3, on:"zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:3, on:"zsh-users/zsh-syntax-highlighting"

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo
    zplug install
  fi
fi

zplug load

# local bins
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/sbin"

# asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
autoload -Uz compinit && compinit

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# k9s
export K9S_CONFIG_DIR="$HOME/.config/k9s"

# set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# startship promt
eval "$(starship init zsh)"

# direnv (silent)
eval "$(direnv hook zsh)"
_direnv_hook() { direnv export zsh 2>/dev/null | source /dev/stdin }

# append all .kube config files
export KUBE_EDITOR='code --wait'
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS specific command
  export KUBECONFIG=$(find ${HOME}/.kube -maxdepth 1 -type f | sort | paste -sd ":" -)
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux specific command
  export KUBECONFIG=$(find ${HOME}/.kube -maxdepth 1 -type f | sort | sed ':a;N;s/\n/:/;ba')
fi

# OpenClaw Completion
[ -s "/home/luizfelipefb/.openclaw/completions/openclaw.zsh" ] && source "/home/luizfelipefb/.openclaw/completions/openclaw.zsh"

# bun completions
[ -s "/home/luizfelipefb/.bun/_bun" ] && source "/home/luizfelipefb/.bun/_bun"

# some aliases
alias cat='bat -P'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias ls='eza'
alias l='eza --icons --group-directories-first -lagh'
alias lt='eza --icons --group-directories-first --tree --level=2 -lagh'
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}'"

# dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# npm-groovy-lint format
alias ngf='npm-groovy-lint -r "Indentation{\"spacesPerIndentLevel\":4,\"severity\":\"error\"},UnnecessarySemicolon,UnnecessaryGString" --fix'

# change eks
alias kjar="kubectl config use-context 'arn:aws:eks:us-east-1:030669393364:cluster/jarvis'"
alias kdev="kubectl config use-context 'arn:aws:eks:us-east-1:030669393364:cluster/develop'"
alias kpre="kubectl config use-context 'arn:aws:eks:us-east-1:030669393364:cluster/preprod'"
alias kprd="kubectl config use-context 'arn:aws:eks:us-east-1:030669393364:cluster/production'"

# claude
alias claude='claude -c'
alias claude-mem='bun "/home/luizfelipefb/.claude/plugins/cache/thedotmack/claude-mem/10.5.5/scripts/worker-service.cjs"'

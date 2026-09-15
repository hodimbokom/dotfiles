autoload -U compinit; compinit

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

setopt auto_cd

alias v='nvim'
alias g='git'

alias vt='v ~/.config/tmux'
alias vz='v ~/.config/zsh'
alias vv='v ~/.config/nvim'
alias va='v ~/.config/alacritty'

alias gs='g switch'
alias ga='g add'
alias gaa='g add .'
alias gstat='g status'
gss() {
  local b
  b="$(git branch --format='%(refname:short)' | fzf)" || return
  git switch "$b"
}

alias doc='$HOME/Documents'
alias dow='$HOME/Downloads'
alias pet='$HOME/Documents/work/pets'
alias dot='$HOME/.config'
alias work='$HOME/Documents/work'

alias tmuxk='tmux kill-session -t'
alias tmuxa='tmux attach -t'
alias tmuxl='tmux list-sessions'

alias cat='bat --style=plain'
alias ls='eza'
alias env='env | sort | bat -l ini --style=plain'

alias jqpp='jq -C . | less -R'


source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--layout=reverse --border --info=inline'
export FZF_TMUX_OPTS='-p 80%,70%'
export FZF_CTRL_T_OPTS='--preview "bat --style=plain --color=always {} 2>/dev/null || eza -alg {}"'
export FZF_ALT_C_OPTS='--preview "eza -alg {}"'
source $(brew --prefix)/opt/fzf/shell/completion.zsh
source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh

bindkey '^I'   autosuggest-accept
bindkey '^[[Z' complete-word

eval "$(starship init zsh)"

[[ -f "$ZDOTDIR/.zshrc.local" ]] && source "$ZDOTDIR/.zshrc.local"

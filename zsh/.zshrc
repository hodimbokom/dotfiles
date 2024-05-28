autoload -U compinit; compinit

setopt auto_cd

bindkey '^I'   autosuggest-accept
bindkey '^[[Z' complete-word

# aliases
alias v='nvim'
alias g='git'

# configs
alias vt='v ~/.config/tmux'
alias vz='v ~/.config/zsh'
alias vv='v ~/.config/nvim'
alias va='v ~/.config/alacritty'

# git
alias gs='g switch'
alias ga='g add'
alias gaa='g add .'
alias gstat='g status'

# dir
alias doc='$HOME/Documents'
alias dow='$HOME/Downloads'
alias pet='$HOME/Documents/work/pets'
alias dot='$HOME/.config'
alias work='$HOME/Documents/work'

# tmux
alias tmuxk='tmux kill-session -t'
alias tmuxa='tmux attach -t'
alias tmuxl='tmux list-sessions'


source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh


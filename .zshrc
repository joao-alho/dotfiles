# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin/:$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

ZSH_THEME=""

DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git zsh-autosuggestions poetry)
source $ZSH/oh-my-zsh.sh
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
 fi
alias "ll=ls -al"
alias "vi=nvim"
alias "vim=nvim"
#alias "pshell=source $(poetry env info --path)/bin/activate"
#Star Ship
eval "$(starship init zsh)"

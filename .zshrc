# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin/:$HOME/bin:/usr/local/bin:$PATH
# Add go to PATH
export PATH=$HOME/.local/go/bin:$HOME/go/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export MANPAGER='nvim +Man!'

ZSH_THEME=""

DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
 fi
alias "ll=ls -al"
alias "vi=nvim"
alias "vim=nvim"
alias "copy=xargs echo -n | xclip -sel clipboard -i"
alias "paste=xclip -sel clipboard -o"
alias "kc=kubectl"
#Star Ship
eval "$(starship init zsh)"
#Zoxide
eval "$(zoxide init zsh)"
alias "cd=z"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

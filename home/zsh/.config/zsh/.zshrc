source "$ZDOTDIR/mac.zsh"

bindkey -v
bindkey '^H' fzf-history-widget
# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
# if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="jnrowe"

plugins=(git fzf timer erc z)
source $ZSH/oh-my-zsh.sh

# Long and good history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"

setopt EXTENDED_HISTORY      # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY    # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY         # Share history between all sessions.
setopt HIST_IGNORE_DUPS      # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS  # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE     # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS     # Do not write a duplicate event to the history file.
setopt HIST_VERIFY           # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY        # append to history file (Default)
setopt HIST_NO_STORE         # Don't store history commands
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from each command line being added to the history.

HIST_STAMPS="yyyy-mm-dd"
#bindkey | grep fzf-history-widget


# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/eoruada/.lmstudio/bin"
# End of LM Studio CLI section

# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

export PATH=/Users/eoruada/dev/tools/getting-started/user-scripts/:$PATH
export PATH=$HOME/dev/scripts:$PATH
export PATH=$HOME/.local/bin:$PATH



### ALIASES
alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'

alias la='ls -a'

alias :q='exit'

alias cl='cd ~/Documents/vault && claude'

boop () {
  local last="$?"
  if [[ "$last" == '0' ]]; then
    say "success"
  else
    say "error"
  fi
  $(exit "$last")
}

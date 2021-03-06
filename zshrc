# ------------------------------------------------------------------------------
# oh my zsh
export ZSH=$HOME/.oh-my-zsh

# set zsh theme early
if [ "$(uname -s)" = "Linux" ]; then
    ZSH_THEME="avit"
else
    ZSH_THEME="bureau"
fi

plugins=(
  git
  z
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# ------------------------------------------------------------------------------
# zsh history
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# ------------------------------------------------------------------------------
export TERM=xterm-256color

# path
LOCAL_PATH=$HOME/local
export PATH=/usr/local/bin:$PATH
export PATH=$LOCAL_PATH/bin:$PATH
export C_PATH=$LOCAL_PATH/include:$C_PATH
export LIBRARY_PATH=$LOCAL_PATH/lib:$LIBRARY_PATH
export LIBRARY_PATH=$LOCAL_PATH/lib64:$LIBRARY_PATH
export LD_LIBRARY_PATH=$LOCAL_PATH/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LOCAL_PATH/lib64:$LD_LIBRARY_PATH


# new command
alias tree="tree -C"
[ -x "$(command -v nvim)" ] && alias vim=nvim && alias vimdiff="vim -d"

alias agcpp="ag --cpp"
alias rmcmake="rm -r CMakeFiles CMakeCache.txt cmake_install.cmake"
alias aria2c="aria2c -j 8"
alias trn="tr '\n' ' '"

alias xargs_pssh="xargs -0 -I {} pssh -H '{}' "
alias xargs_keyscan="xargs ssh-keyscan >> $HOME/.ssh/known_hosts"


[ -f "$HOME/.custom-conf/custom-env.sh" ] && source $HOME/.custom-conf/custom-env.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

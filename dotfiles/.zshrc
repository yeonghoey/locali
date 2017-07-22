export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH"
export ZSH="$HOME/.local/repo/oh-my-zsh"

ZSH_THEME='afowler'
plugins=(git colorize osx zsh-navigation-tools)

source "$HOME/.localrc"
source "$ZSH/oh-my-zsh.sh"

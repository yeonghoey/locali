if [[ -f "$HOME/.localrc" ]]; then
  source "$HOME/.localrc"
fi

ZSH_THEME='afowler'
plugins=(git colorize osx zsh-navigation-tools)

source "$ZSH/oh-my-zsh.sh"

# export ZSH="$HOME/.local/repo/oh-my-zsh"

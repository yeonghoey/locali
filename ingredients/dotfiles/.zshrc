if [[ -f "$HOME/.localrc" ]]; then
  source "$HOME/.localrc"
fi

if [[ "$ZSH" ]]; then
  ZSH_THEME='afowler'
  plugins=(git colorize osx zsh-navigation-tools)
  source "$ZSH/oh-my-zsh.sh"
fi

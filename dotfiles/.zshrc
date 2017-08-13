if [[ -f "$HOME/.localrc" ]]; then
  source "$HOME/.localrc"
fi

# oh-my-zsh
if [[ "$ZSH" ]]; then
  ZSH_THEME='afowler'
  plugins=(
    git
    colorize
    osx
    zsh-navigation-tools
    zsh-completions
  )
  source "$ZSH/oh-my-zsh.sh"
fi

# Ensure compinit
autoload -U compinit && compinit

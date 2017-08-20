# .localrc
if [[ -f "$HOME/.localrc" ]]; then
  source "$HOME/.localrc"
fi

if [[ -f "$HOME/.localrc.zsh" ]]; then
  source "$HOME/.localrc.zsh"
fi

# oh-my-zsh
if [[ "$ZSH" ]]; then
  export ZSH_THEME='afowler'
  export plugins=(
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

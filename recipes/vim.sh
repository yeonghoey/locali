# * | install 'Vundle.vim' [dotfiles]

# ------------------------------------------------------------------------------

repo_git 'https://github.com/VundleVim/Vundle.vim.git'
repo_sym 'Vundle.vim' "$HOME/.vim/bundle/Vundle.vim"
vim +PluginInstall +qall

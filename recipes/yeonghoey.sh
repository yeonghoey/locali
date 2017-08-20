# persionalize 'locali.sh' and clone personal repositories

# ------------------------------------------------------------------------------

git -C "${LOCALISH}" remote set-url \
    origin 'git@github.com:yeonghoey/locali.sh.git'

# ------------------------------------------------------------------------------

repo_git 'git@github.com:yeonghoey/yeonghoey.git'
repo_run 'yeonghoey/update.sh'
repo_sym 'yeonghoey' "$HOME/yeonghoey"

# ------------------------------------------------------------------------------

repo_git 'git@github.com:yeonghoey/yeonghoey-org.git'
repo_run 'yeonghoey-org/update.sh'
repo_sym 'yeonghoey-org' "$HOME/yeonghoey-org"

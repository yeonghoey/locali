# persionalize 'locali.sh' and clone personal repositories

# ------------------------------------------------------------------------------

info "Set url of 'origin': 'git@github.com:yeonghoey/locali.sh.git'"
git -C "${LOCALISH}" remote set-url \
    origin 'git@github.com:yeonghoey/locali.sh.git'

# ------------------------------------------------------------------------------

GIT_LFS_SKIP_SMUDGE=1 \
  repo_git 'git@github.com:yeonghoey/yeonghoey.git'
repo_sym 'yeonghoey' "$HOME/yeonghoey"
repo_run 'yeonghoey/update.sh'

# ------------------------------------------------------------------------------

repo_git 'git@github.com:yeonghoey/yeonghoey-org.git'
repo_sym 'yeonghoey-org' "$HOME/yeonghoey-org"
repo_run 'yeonghoey-org/update.sh'

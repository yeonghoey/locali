# install personal repositories

# ------------------------------------------------------------------------------

info "Set url of 'origin': 'git@github.com:yeonghoey/locali.git'"
git -C "${LOCALI}" remote set-url \
    origin 'git@github.com:yeonghoey/locali.git'

# ------------------------------------------------------------------------------

GIT_LFS_SKIP_SMUDGE=1 \
  repo_git 'git@github.com:yeonghoey/yeonghoey.git'
repo_sym 'yeonghoey' "$HOME/yeonghoey"
repo_run 'yeonghoey/update.sh'

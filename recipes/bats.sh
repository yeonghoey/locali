# * | install 'bats'

repo_git 'https://github.com/sstephenson/bats.git'
repo_run 'bats/install.sh' "${LOCAL_ROOT}"

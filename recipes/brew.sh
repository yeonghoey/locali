# install 'brew' {macOS}

info 'Require macOS'
on_macos || return 1

repo_git 'https://github.com/Homebrew/brew.git'
repo_bin 'brew/bin/brew'

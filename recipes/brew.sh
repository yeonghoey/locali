# install brew under ~/.local/repos

info 'Require macOS'
on_macos || return 1

INSTALL_URL='https://raw.githubusercontent.com/Homebrew/install/master/install'
/usr/bin/ruby -e "$(curl -fsSL "$INSTALL_URL")"

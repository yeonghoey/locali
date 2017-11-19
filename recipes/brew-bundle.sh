# install brew, cask, mas packages

brew bundle --verbose --file=<(cat <<EOF

tap 'caskroom/cask'
tap 'd12frosted/emacs-plus'

brew 'cmake'
brew 'emacs-plus'
brew 'fasd'
brew 'ffmpeg'
brew 'fpp'
brew 'gawk'
brew 'git'
brew 'git-extras'
brew 'git-flow'
brew 'git-lfs'
brew 'go'
brew 'hub'
brew 'imagemagick'
brew 'ispell'
brew 'jq'
brew 'mas'
brew 'node'
brew 'openssl'
brew 'readline'
brew 'reattach-to-user-namespace'
brew 'shellcheck'
brew 'stow'
brew 'the_silver_searcher'
brew 'tmux'
brew 'tree'
brew 'watch'
brew 'wget'
brew 'xz'
brew 'zsh'

cask '1password'
cask 'anki'
cask 'betterzipql'
cask 'docker-toolbox'
cask 'dropbox'
cask 'firefox'
cask 'flycut'
cask 'google-backup-and-sync'
cask 'google-chrome'
cask 'iterm2'
cask 'java'
cask 'mactex'
cask 'qlcolorcode'
cask 'qlimagesize'
cask 'qlmarkdown'
cask 'qlprettypatch'
cask 'qlstephen'
cask 'quicklook-csv'
cask 'quicklook-json'
cask 'slack'
cask 'spectacle'
cask 'steam'
cask 'visualvm'

mas 'KakaoTalk',                id: 869223134
mas 'Kindle',                   id: 405399194
mas 'Lightshot Screenshot',     id: 526298438
mas 'Microsoft Remote Desktop', id: 715768417
mas 'Movist',                   id: 461788075
mas 'Pixelmator',               id: 407963104

EOF
)

symlink '/Library/Tex/texbin/pdflatex' "${LOCAL_BIN}/pdflatex"

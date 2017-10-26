# add apt repositories and install packages

# ------------------------------------------------------------------------------

on_ubuntu

# ------------------------------------------------------------------------------

readonly REPOSITORIES=(
  ppa:git-core/ppa
)

readonly PACKAGES=(
  build-essential
  curl
  dvipng  # For LaTeX
  emacs
  gawk
  git
  git-flow
  libbz2-dev
  libcurl4-openssl-dev
  libncurses5-dev
  libncursesw5-dev
  libreadline-dev
  libsqlite3-dev
  libssl-dev
  llvm
  make
  nodejs
  nodejs-legacy # for 'node' command
  npm
  silversearcher-ag
  stow
  texlive    # LaTeX
  texstudio  # SEE: https://tex.stackexchange.com/questions/289458/download-and-installation-of-latex-for-linux-ubuntu
  tk-dev
  wget
  xz-utils
  zlib1g-dev
  zsh
)

sudo add-apt-repository -y "${REPOSITORIES[@]}"
sudo apt update
sudo apt install -y "${PACKAGES[@]}"

# Post install: 'git-lfs' requires 'curl'
curl -s 'https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh' | sudo bash
sudo apt install -y git-lfs

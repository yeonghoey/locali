# Add apt repositories and install packages

# ------------------------------------------------------------------------------

require_ubuntu

# ------------------------------------------------------------------------------

readonly REPOSITORIES=(
  ppa:git-core/ppa
)

readonly PACKAGES=(
  build-essential
  curl
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
  npm
  shellcheck
  stow
  tk-dev
  wget
  xz-utils
  zlib1g-dev
)

sudo add-apt-repository -y "${REPOSITORIES[@]}"
sudo apt-get update
sudo apt-get install -y "${PACKAGES[@]}"

# Post install: 'git-lfs' requires 'curl'
curl -s 'https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh' | sudo bash
sudo apt-get install -y git-lfs

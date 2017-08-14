# Add apt repositories and install packages

# ------------------------------------------------------------------------------

# require_ubuntu

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

sudo add-apt-repository "${REPOSITORIES[@]}"
sudo apt-get update
sudo apt-get install -y "${PACKAGES[@]}"

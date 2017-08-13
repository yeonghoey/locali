# Add apt repositories and install packages

# ------------------------------------------------------------------------------

# require_ubuntu

# ------------------------------------------------------------------------------

readonly PACKAGES=(
  build-essential
  curl
  emacs
  gawk
  libbz2-dev
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

echo sudo apt-get update
echo sudo apt-get install -y "${PACKAGES[@]}"
echo sudo apt autoremove

ubuntu && {
  use_sudo
  cat "${LOCALISH}/etc/apt-repositories.txt" | xargs sudo add-apt-repository
  sudo apt-get update
  cat "${LOCALISH}/etc/apt-packages.txt" | xargs sudo apt-get install -y
  sudo apt autoremove
}

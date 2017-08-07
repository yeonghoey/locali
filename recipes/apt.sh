ubuntu && {
  use_sudo
  sudo apt-get update
  cat "${LOCALISH}/etc/apt.txt" | xargs sudo apt install -y
  sudo apt autoremove
}

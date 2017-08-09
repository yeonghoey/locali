ubuntu && {
  cat "${LOCALISH}/ingredients/apt-repositories.txt" | xargs sudo add-apt-repository
  sudo apt-get update
  cat "${LOCALISH}/ingredients/apt-packages.txt" | xargs sudo apt-get install -y
  sudo apt autoremove
}

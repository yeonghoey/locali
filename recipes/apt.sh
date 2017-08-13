# Add apt repositories and install packages

# ------------------------------------------------------------------------------

require_ubuntu

# ------------------------------------------------------------------------------

sudo add-apt-repository "$(requirements "${LOCALISH}/apt/repositories.txt")"
sudo apt-get update
sudo apt-get install -y "$(requirements "${LOCALISH}/apt/packages.txt")"
sudo apt autoremove

# configure GitHub SSH key

# Generate '.ssh/id_rsa'
ID_RSA="${HOME}/.ssh/id_rsa"

if [[ ! -f "${ID_RSA}" ]]; then

  prompt 'GitHub email'
  GITHUB_EMAIL="$(answer)"

  # Pass prompts
  echo | ssh-keygen -t rsa -b 4096 -C "${GITHUB_EMAIL}" -P ''
  #  |                                                   +- no passphrase
  #  +- pass prompt.
  #     use only the default file path('.ssh/id_rsa')

  eval "$(ssh-agent -s)"
  ssh-add "${ID_RSA}"

fi

info 'Paste following public key on GitHub SSH menu'
echo '--------------------------------------------------------------------------------'
cat "${ID_RSA}.pub"
echo '--------------------------------------------------------------------------------'

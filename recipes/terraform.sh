macos && {
  repo_zip \
    'https://releases.hashicorp.com/terraform/0.10.0/terraform_0.10.0_darwin_amd64.zip' \
    'terraform'
}

repo_bin 'terraform/terraform'

# create ~/.pypirc

# ------------------------------------------------------------------------------

readonly PYPIRC="${HOME}/.pypirc"

if [[ -e "${PYPIRC}" ]]; then
  info "'${PYPIRC}' already exists. skipped."
  cat "${PYPIRC}"
  return 0
fi

prompt 'username'
USERNAME="$(answer)"

prompt 'password'
PASSWORD="$(answer)"

require_file "${PYPIRC}" <<EOF
[distutils]
index-servers =
  pypi
  pypitest

[pypi]
username=${USERNAME}
password=${PASSWORD}

[pypitest]
repository=https://test.pypi.org/legacy
username=${USERNAME}
password=${PASSWORD}
EOF

chmod 600 "${PYPIRC}"

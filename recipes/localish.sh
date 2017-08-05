stow --dir="${LOCALISH}" --target="${LOCAL_BIN}" 'bin'

localrc 'localish' << EOF
export PATH="${LOCAL_BIN}:\${PATH}"
EOF

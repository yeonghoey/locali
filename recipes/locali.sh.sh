symlink "${LOCALISH}/locali.sh" "${LOCAL_BIN}/locali.sh"

localrc 'locali.sh' << EOF
export PATH="${LOCAL_BIN}:\${PATH}"
EOF

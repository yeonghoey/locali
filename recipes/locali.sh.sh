# bootstrap

symlink "${LOCALI}/locali" "${LOCAL_BIN}/locali"


localrc 'locali' <<EOF

export PATH="${LOCAL_BIN}:\${PATH}"

EOF


localrc_zsh 'locali' <<EOF

fpath=("${LOCAL_COMPS_ZSH}" \$fpath)

EOF

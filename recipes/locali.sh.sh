# install 'locali.sh'

symlink "${LOCALISH}/locali.sh" "${LOCAL_BIN}/locali.sh"


localrc 'locali.sh' <<EOF

export PATH="${LOCAL_BIN}:\${PATH}"

EOF


localrc_zsh 'locali.sh' <<EOF

fpath=("${LOCAL_COMPS_ZSH}" \$fpath)

EOF

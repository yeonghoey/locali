# bootstrap

symlink "${LOCALI}/locali" "${LOCAL_BIN}/locali"
localrc 'locali' <<EOF

export PATH="${LOCAL_BIN}:\${PATH}"

EOF


localrc_zsh 'locali' <<EOF

fpath=("${LOCAL_COMPS_ZSH}" \$fpath)

EOF

# ------------------------------------------------------------------------------
# install personal repositories
# ------------------------------------------------------------------------------
info "Set url of 'origin': 'git@github.com:yeonghoey/locali.git'"
git -C "${LOCALI}" remote set-url \
    origin 'git@github.com:yeonghoey/locali.git'

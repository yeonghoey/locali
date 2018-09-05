# install go and go utils
brew bundle --verbose --file=<(cat <<EOF
brew 'go'
EOF
)

# shellcheck disable=SC2016
readonly EXPORT_GOPATH='export GOPATH="${HOME}/go"'

localrc 'go' << EOF

${EXPORT_GOPATH}
export PATH="\${PATH}:\$(go env GOPATH)/bin"

EOF

# Depend on GOPATH for current shell
eval "${EXPORT_GOPATH}"

# Install dependencies on which Spacemacs depends
go get -u -v github.com/mdempsky/gocode
go get -u -v github.com/rogpeppe/godef
go get -u -v golang.org/x/tools/cmd/guru
go get -u -v golang.org/x/tools/cmd/gorename
go get -u -v golang.org/x/tools/cmd/goimports
go get -u -v github.com/zmb3/gogetdoc
go get -u -v github.com/cweill/gotests/...
go get -u github.com/haya14busa/gopkgs/cmd/gopkgs
go get -u -v github.com/davidrjenni/reftools/cmd/fillstruct
go get -u github.com/josharian/impl

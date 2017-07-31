#!/usr/bin/env bash



# Add to PATH for current use
export PATH="${LOCAL_BIN}:${PATH}"

# Add to PATH in ~/.localrc for future use
localrc-add 'localish' << EOF
export PATH="${LOCAL_BIN}:\${PATH}"
EOF

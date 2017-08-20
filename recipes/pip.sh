# * | install packages [pyenv-install]

# ------------------------------------------------------------------------------

info "Use '$(command_path 'pip')'"

pip install -r <(cat <<EOF

boto3==1.4.1
botocore==1.4.78
bpython==0.16
requests==2.18.3

EOF
)

# ------------------------------------------------------------------------------

info "Use '$(command_path 'pip3')'"

pip3 install -r <(cat <<EOF

clipboard==0.0.4
pycurl==7.43.0

EOF
)

# install packages through both pip and pip3

# ------------------------------------------------------------------------------

info "Use '$(command_path 'pip')'"

pip install -r <(cat <<EOF

ansible==2.4.0.0
boto3==1.4.1
botocore==1.4.78
bpython==0.16
click==6.7
google-cloud=0.32.0
gcloud==0.18.3
requests==2.18.3

EOF
)

# ------------------------------------------------------------------------------

info "Use '$(command_path 'pip3')'"

pip3 install -r <(cat <<EOF

click==6.7
clipboard==0.0.4
mkup==0.0.1
requests==2.18.3

EOF
)

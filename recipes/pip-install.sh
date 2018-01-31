# install packages through both pip and pip3

# ------------------------------------------------------------------------------

info "Use '$(command_path 'pip')'"

pip install -r <(cat <<EOF

ansible==2.4.0.0
boto3==1.4.1
botocore==1.4.78
bpython==0.16
click==6.7
google-api-python-client==1.6.4
google-cloud==0.32.0
pydub==0.20.0
pyperclip==1.6.0
requests==2.18.3
SpeechRecognition==3.8.1

EOF
)

# ------------------------------------------------------------------------------

info "Use '$(command_path 'pip3')'"

pip3 install -r <(cat <<EOF

click==6.7
cookiecutter==1.6.0
hew>=0.0.3
pyperclip==1.6.0
pytube==8.0.2
mkup==0.0.1
requests==2.18.3

EOF
)

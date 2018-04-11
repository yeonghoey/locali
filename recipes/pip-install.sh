# install packages through both pip and pip3

# ------------------------------------------------------------------------------

info "Use '$(pyenv which 'pip')'"

pip install -r <(cat <<EOF

click==6.7
cookiecutter==1.6.0
hew>=0.0.3
pipenv==10.1.0
pyperclip==1.6.0
pytube==8.0.2
mkup==0.0.1
requests==2.18.3

EOF
)

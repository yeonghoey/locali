# install npm global pacakges

localrc 'npm' << EOF
export PATH="node_modules/.bin:\${PATH}"
EOF

npm install --global awsmobile-cli
npm install --global eslint
npm install --global js-beautify
npm install --global nodemon
npm install --global tern
npm install --global vue-cli

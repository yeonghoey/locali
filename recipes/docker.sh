# 1. Install docker-toolbox ('docker-machine' included)
brew bundle --verbose --file=<(cat <<EOF

tap 'caskroom/cask'
cask 'docker-toolbox'

EOF
)

# 2. Create default docker-machine if not exists
docker_machine_exists() {
  docker-machine status "$1" > /dev/null 2>&1
}

if ! docker_machine_exists 'default'; then
  docker-machine create --driver virtualbox default
fi

# 3. Register the default docker-machine to run at startup
readonly LAUNCH_AGENTS="${HOME}/Library/LaunchAgents"
readonly PLIST_PATH="${LAUNCH_AGENTS}/com.docker.machine.default.plist"

# TODO: Support macOS Startup API
require_content "${PLIST_PATH}" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>Label</key>
        <string>com.docker.machine.default</string>
        <key>ProgramArguments</key>
        <array>
            <string>$(command_path 'docker-machine')</string>
            <string>start</string>
            <string>default</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
    </dict>
</plist>
EOF

# 4. Use the docker-machine by default
localrc 'docker' << 'EOF'
if [[ -z "${DOCKER_HOST}" ]]; then
  eval $(docker-machine env default)
fi
EOF

# Add ANKI_MEDIA which anki scripts depend on to .localrc (macOS, Anki2)

# ------------------------------------------------------------------------------

on_macos

# ------------------------------------------------------------------------------

prompt 'Anki Prfile Name'

localrc 'anki' <<EOF
export ANKI_MEDIA="\$HOME/Library/Application Support/Anki2/$(answer)/collection.media"
EOF

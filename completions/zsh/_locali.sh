#compdef locali.sh

# ------------------------------------------------------------------------------

realdir() {
  if [[ -z "$1" ]]; then
    pwd
  else
    (
      cd "$(dirname "$1")" || return
      realdir "$(readlink "$(basename "$1")")"
    )
  fi
}

readonly LOCALISH="$(realdir "$(command -v 'locali.sh')")"

# ------------------------------------------------------------------------------

local -a recipes
#      └─ array

local name
local line
local -a elems
#      └─ array
local desc

recipes=()
for recipe in $LOCALISH/recipes/*.sh; do
  name="$(basename "${recipe%.*}")"
  line="$(head -n 1 "$recipe")"

  # Remove leading '# '
  line="${line#\# }"

  # Split the line by  ' | '
  # '@' modifier is zsh specific
  elems=("${(@s/ | /)line}")

  desc="$(printf '%6s | %s' "${elems[@]}")"
  recipes+=("${name}:${desc}")
done

# ------------------------------------------------------------------------------

_describe 'recipes' recipes

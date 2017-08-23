#compdef locali

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

readonly LOCALI="$(realdir "$(command -v 'locali')")"

# ------------------------------------------------------------------------------

local -a recipes
#      └─ array

local name
local desc

recipes=()
for recipe in $LOCALI/recipes/*.sh; do
  name="$(basename "${recipe%.*}")"
  desc="$(head -n 1 "$recipe")"

  # Remove leading '# '
  desc="${desc#\# }"

  recipes+=("${name}:${desc}")
done

# ------------------------------------------------------------------------------

_describe 'recipes' recipes

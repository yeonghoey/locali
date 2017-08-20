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

local recipe_name
local recipe_desc

recipes=()
for recipe in $LOCALISH/recipes/*.sh; do
  recipe_name="$(basename "${recipe%.*}")"
  recipe_desc="$(head -n 1 "$recipe")"

  # Remove leading '# '
  recipe_desc="${recipe_desc#\# }"

  recipes+=("${recipe_name}:${recipe_desc}")
done

# ------------------------------------------------------------------------------

_describe 'recipes' recipes

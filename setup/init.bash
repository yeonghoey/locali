#!/usr/bin/env bash

export LOCAL_ROOT="${HOME}/.local"
export LOCAL_REPO="${LOCAL_ROOT}/repo"
export LOCAL_BIN="${LOCAL_ROOT}/bin"
export LOCALRC="${HOME}/.localrc"

mkdir -p "${LOCAL_ROOT}"
mkdir -p "${LOCAL_REPO}"
mkdir -p "${LOCAL_BIN}"
touch "${LOCALRC}"

localrc() {
  local label="$1"
  local content="$(homepath "$(cat -)")"

  # Put label
  content="$(echo -e "# ${label}\n${content}")"

  # Append content only when the content is not literally matched
  if ! grep -qF "${content}" "${LOCALRC}"; then
    # Put a blank line
    echo -e "\n${content}" | tee -a "${LOCALRC}"
  fi
}

homepath() {
  # Replace '/user/<username>/.local/*' with '${HOME}/.local/*'
  local content="$1"
  local relpath="${LOCAL_ROOT#"${HOME}"}"
  local sedexp="s:${LOCAL_ROOT}:\${HOME}${relpath}:g"
  echo "$content" | sed "${sedexp}"
}

gitrepo() {
  local url="$1"
  local name="$(basename ${url} .git)"
  if [[ "$#" == 1 ]]; then
    local target="${LOCAL_REPO}/${name}"
  elif [[ "$#" == 2 ]]; then
    local prefix="$2"
    local target="${LOCAL_REPO}/${prefix}/${name}"
  fi
  if [[ -d "${target}" ]]; then
    git -C "${target}" pull
  else
    # Ensure the parent directories exist
    mkdir -p "${target}"
    git clone "${url}" "${target}"
  fi
}

binlink() {
  local src="${LOCAL_REPO}/$1"
  local dst="${LOCAL_BIN}/"
  if [[ "$#" == 2 ]]; then
    dst="$dst/$2"
  fi
  # -i, interactive
  # -s, symlink
  ln -is "$src" "$dst"
}

# Add to PATH for current use
export PATH="${LOCAL_BIN}:${PATH}"

# Add to PATH in ~/.localrc for future use
localrc 'localish' << EOF
export PATH="${LOCAL_BIN}:\${PATH}"
EOF

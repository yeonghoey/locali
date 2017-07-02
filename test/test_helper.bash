setup() {
  export LOCALISH="${BATS_TEST_DIRNAME}/.."
  export TESTDIR="${BATS_TMPDIR}/localish"
  export HOME="${TESTDIR}"
  mkdir -p "${HOME}"
}

teardown() {
  rm -rf "${TESTDIR}"
}

X() {
  fail '>>> X <<< '
}

assert_success() {
  if [[ "$status" -ne 0 ]]; then
    fail "Failed with exit status $status"
  fi
}

assert_failure() {
  if [[ "$status" -eq 0 ]]; then
    fail "Expected to fail, but succeeded"
  fi
}

assert_file() {
  if [[ "$#" -eq 1 ]]; then
    assert_equal "$(cat "$1")"
  elif [[ "$#" -eq 2 ]]; then
    assert_equal "$(cat "$1")" "$(cat "$2")"
  else
    assert_equal "$@"
  fi
}

assert_line() {
  if [[ "$1" -ge 0 ]] 2> /dev/null; then
    local i="$1"
    local expected="$2"
    assert_equal "$expected" "${lines[$i]}"
  else
    # Test whether $lines have $expected
    local expected="$1"
    local line
    for line in "${lines[@]}"; do
      if [[ "$line" == "$expected" ]]; then
        return 0
      fi
    done
    fail "expected line \`$expected'"
  fi
}

assert_equal() {
  local expected
  local actual
  if [[ "$#" -eq 1 ]]; then
    expected="$(cat -)"
    actual="$1"
  elif [[ "$#" -eq 2 ]]; then
    expected="$1"
    actual="$2"
  else
    fail "assert_equal accepts only one or two args, but got $#"
    return 1
  fi

  if [[ "$expected" != "$actual" ]]; then
    {
      info 'EXPECTED:' "$expected"
      info 'ACTUAL:' "$actual"
    } | fail
  fi
}

fail() {
  { if [[ "$#" -eq 0 ]]; then
      cat -
    else
      echo "$@"
    fi
  } | sed "s:${TESTDIR}:<TESTDIR>:g"

  echo
  info "TESTDIR:" "${TESTDIR}"
  info "OUTPUT:" "$output" | sed "s:${TESTDIR}:<TESTDIR>:g"
  return 1
}

info() {
  local label="$1"
  local message="$2"
  echo "$label"
  echo "$message" | sed 's/^/  /'
}

setup() {
  export LOCALISH="${BATS_TEST_DIRNAME}/.."
  export TESTDIR="${BATS_TMPDIR}/localish"
  export HOME="${TESTDIR}"
  mkdir -p "${HOME}"
}

teardown() {
  rm -rf "${TESTDIR}"
}

assert_success() {
  if [[ "$status" -ne 0 ]]; then
    fail "Failed with exit status $status"
  fi
}

assert_file() {
  local expected
  local actual
  if [[ "$#" -eq 1 ]]; then
    expected="$(cat -)"
    actual="$(cat "$1")"
  else
    expected="$1"
    actual="$(cat "$2")"
  fi
  assert_equal "$expected" "$actual"
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
        return 0;
      fi
    done
    fail "expected line \`$expected'"
  fi
}

assert_equal() {
  if [[ "$1" != "$2" ]]; then
    { echo "EXPECTED: $1"
      echo "ACTUAL:   $2"
    } | fail
  fi
}

fail() {
  { if [[ "$#" -eq 0 ]]; then
      cat -
    else
      echo "$@"
    fi
  } | sed "s:${TESTDIR}:<TESTDIR>:g" >&2

  echo
  echo 'TESTDIR:'
  echo "  ${TESTDIR}"
  echo 'OUTPUT:'
  echo "$output" | \
    sed "s:${TESTDIR}:<TESTDIR>:g" | \
    sed -e 's/^/  /' >&2 # indent 2 spaces
  return 1
}

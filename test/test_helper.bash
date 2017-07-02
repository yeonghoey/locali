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
    { echo "expected: $1"
      echo "actual:   $2"
    } | fail
  fi
}

fail() {
  echo "$@" | sed "s:${TESTDIR}:<TESTDIR>:g" >&2
  echo
  echo 'TESTDIR:'
  echo "  ${TESTDIR}"
  echo 'OUTPUT:'
  echo "$output" | \
    sed "s:${TESTDIR}:<TESTDIR>:g" | \
    sed -e 's/^/  /' >&2 # indent 2 spaces
  return 1
}

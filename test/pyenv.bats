#!/usr/bin/env bats

load test_helper

@test "pyenv" {
  run "${LOCALI}/pyenv"
  assert_success
  assert_line 0 "Cloning into '${TESTDIR}/.local/repos/.pyenv'..."
  assert_line 1 "Cloning into '${TESTDIR}/.local/repos/.pyenv/plugins/pyenv-virtualenv'..."

  run "${LOCALI}/pyenv"
  assert_success
  assert_line 0 "Already up-to-date."
  assert_line 1 "Already up-to-date."

  { cat << EOF
export PYENV_ROOT="${TESTDIR}/.local/repos/.pyenv"
export PATH="\$PYENV_ROOT/bin:\$PATH"
eval "\$(pyenv init -)"            # should be placed at very last
eval "\$(pyenv virtualenv-init -)" # should be placed at very last
EOF
  } | assert_file "${TESTDIR}/.localrc"
}

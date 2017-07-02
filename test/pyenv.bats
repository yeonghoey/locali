#!/usr/bin/env bats

load test_helper

@test "install pyenv" {
  run "${LOCALISH}/pyenv"
  assert_success
  assert_line 0 "Cloning into '${TESTDIR}/.local/repos/.pyenv'..."
  assert_line 1 "Cloning into '${TESTDIR}/.local/repos/.pyenv/plugins/pyenv-virtualenv'..."

  run "${LOCALISH}/pyenv"
  assert_success
  assert_line 0 "Already up-to-date."
  assert_line 1 "Already up-to-date."
}

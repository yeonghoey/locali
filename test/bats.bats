#!/usr/bin/env bats

load test_helper

@test "install bats" {
  run "${LOCALISH}/bats"
  assert_success
  assert_line "Cloning into '${TESTDIR}/.local/repos/bats'..."
  assert_line "Installed Bats to ${TESTDIR}/.local/bin/bats"

  run "${LOCALISH}/bats"
  assert_success
  assert_line "Already up-to-date."
  assert_line "Installed Bats to ${TESTDIR}/.local/bin/bats"
}

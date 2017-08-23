#!/usr/bin/env bats

load test_helper

assert_equal_piped() {
  echo "$1" | assert_equal "$2"
}

@test "assert_equal" {
  run assert_equal 1 1
  assert_success

  run assert_equal 1 2
  assert_failure
  assert_line 0 'EXPECTED:'
  assert_line 1 '  1'
  assert_line 2 'ACTUAL:'
  assert_line 3 '  2'

  run assert_equal 1 2 3
  assert_failure
  assert_line 'assert_equal accepts only one or two args, but got 3'
}

@test "assert_equal_piped" {
  run assert_equal_piped 1 1
  assert_success

  run assert_equal_piped 1 2
  assert_failure
  assert_line 0 'EXPECTED:'
  assert_line 1 '  1'
  assert_line 2 'ACTUAL:'
  assert_line 3 '  2'
}


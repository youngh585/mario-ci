#!/usr/bin/env bash
set -euo pipefail

# 1) Build (adjust the path if your mario.c is elsewhere)
clang -Wall -Wextra -Werror -std=c11 -O2 -DCI -o mario mario-less/mario.c

# If your code prints a prompt like "Height: ", hide it in CI:
# clang ... -DCI -o mario mario-less/mario.c
# and wrap your prompt in the code with:
#   #ifndef CI
#   printf("Height: ");
#   #endif

# 2) Run tests (adjust/extend cases as needed)
run_case () {
  local in="$1"; local exp="$2"
  # trim trailing spaces in output before comparing
  got="$(./mario < "$in" | sed -e 's/[[:space:]]\+$//')"
  diff -u <(printf "%s\n" "$got") <(sed -e 's/[[:space:]]\+$//' "$exp")
  echo "✅ Passed: $in"
}

run_case tests/input_1.txt tests/expected_1.txt
run_case tests/input_4.txt tests/expected_4.txt

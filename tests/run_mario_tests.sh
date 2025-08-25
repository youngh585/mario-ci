#!/usr/bin/env bash
set -euo pipefail

SRC="mario-less/mario.c"
BIN="tests/mario"
TESTS_DIR="tests"

# Compile Mario
clang -ggdb3 -O0 -std=c11 -Wall -Wextra -Werror -pedantic "$SRC" -lcs50 -o "$BIN"

# Normalize output
# 1. Remove carriage returns
# 2. Remove the 'Height:' prompt and spaces before first row
# 3. Trim trailing spaces
# 4. Remove blank lines
normalize() {
  sed -e 's/\r//g' \
      -e 's/^[Hh]eight:[[:space:]]*//' \
      -e 's/[[:space:]]*$//' \
      -e '/^$/d'
}

# Run single test
run_case() {
  local input="$1"
  local expected="$2"
  "$BIN" <<< "$input" | normalize > "$TESTS_DIR/out.txt"
  if diff -u "$expected" "$TESTS_DIR/out.txt"; then
    echo "✔ Passed input=$input against $(basename $expected)"
  else
    echo "❌ Failed input=$input against $(basename $expected)"
  fi
}

# Run all test cases
run_case "1" "$TESTS_DIR/expected_1.txt"
run_case "4" "$TESTS_DIR/expected_4.txt"
run_case "8" "$TESTS_DIR/expected_8.txt"

echo "✅ All Mario tests complete"

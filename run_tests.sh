#!/usr/bin/env bash

set -e

FAILED=0

cargo build --quiet

for input in test/*.in; do
    [ -e "$input" ] || continue

    base="${input%.in}"
    expected="${base}.out"

    if [ ! -f "$expected" ]; then
        echo "Missing expected output file for $input"
        FAILED=1
        continue
    fi

    echo -n "$(basename "$base"): "

    if diff -u -Z <(cargo run --quiet < "$input") "$expected" > /dev/null; then
        echo "PASS"
    else
        echo "FAIL"
        diff -u -Z "$expected" <(cargo run --quiet < "$input") || true
        FAILED=1
    fi
done

exit $FAILED

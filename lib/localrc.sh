#!/usr/bin/env bash

set -euo pipefail

localrc-append() {
    local line="$1"
    echo "$line"
}

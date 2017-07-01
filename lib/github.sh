#!/usr/bin/env bash

set -euo pipefail

github-fresh() {
    local repo="$1"
    local directory="$2"
    echo "$repo"
    echo "$directory"
}

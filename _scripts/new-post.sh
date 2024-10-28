#!/bin/bash

set -eu

function usage() {
    local msg="${1:-}"
    if [ -z "$msg" ]; then
        echo "Error: $msg" >&2
    fi
    echo "usage: $(basename $0) <title>" >&2
    exit 1
}

scriptdir=$(dirname "$(readlink -f "$0")")
cd "$scriptdir/.."

title="${1:-}"

if [ -z "$title" ]; then
    usage "Missing title."
fi
if [ -n "${2:-}" ]; then
    usage "Too many arguments: $@"
fi

_title=$(echo "$title" | sed 's/ /-/g' | tr '[:upper:]' '[:lower:]')
date=$(date -u +%Y-%m-%d)
time=$(date -u "+%T %z")
post="_posts/$date-$_title.md"

if [ -e "$post" ]; then
    usage: "Post '$post' already exists."
fi

cat > "$post" <<EOF
---
layout: post
title:  "$title"
date:   $date $time
categories: []
---
EOF

echo "OK: '$post' is ready to edit."
exit 0
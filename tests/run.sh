#!/bin/sh
# Run a program with our malloc preloaded: tests/run.sh <program> [args...]

ROOT=$(cd "$(dirname "$0")/.." && pwd)
LIB="$ROOT/libft_malloc.so"

if [ $# -eq 0 ]; then
    echo "usage: $0 <program> [args...]" >&2
    exit 1
fi
if [ ! -f "$LIB" ]; then
    echo "$0: $LIB not found, run make first" >&2
    exit 1
fi

export LD_LIBRARY_PATH="$ROOT"
export LD_PRELOAD="$LIB"
exec "$@"

#!/usr/bin/env bash
# chizu.parcel は zip ごとの Parquet を 2,000 本ほど一度に読む。macOS の既定では開けるファイル数が
# 256 で、DuckDB が「Too many open files」で止まるので、上限を上げてから作る
ulimit -n 65536 2>/dev/null || ulimit -n "$(ulimit -Hn)"
exec "$(dirname "$0")/../shared/scripts/build-fdl.sh" "$@"

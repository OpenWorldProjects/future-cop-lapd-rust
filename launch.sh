#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
case "$(uname -s)" in
    Darwin) BIN=target/x86_64-apple-darwin/release/fcop ;;
    Linux) BIN=target/release/fcop ;;
    *) echo 'Use the Windows executable or cargo run --locked --release --bin fcop.' >&2; exit 1 ;;
esac
if [[ ! -x "$BIN" ]]; then
    echo 'Build first with ./setup_macos.sh or ./setup_linux.sh.' >&2
    exit 1
fi
mkdir -p game_files
exec "$BIN" "$@"

#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
if [[ "$(uname -s)" != Darwin || "$(uname -m)" != x86_64 ]]; then
    echo 'This experimental macOS build targets Intel Macs (x86_64), including the 2015 MacBook Pro.' >&2
    exit 1
fi
if ! xcode-select -p >/dev/null 2>&1; then
    echo 'Install Apple command line tools with: xcode-select --install; then rerun this script.' >&2
    exit 1
fi
if ! command -v cargo >/dev/null 2>&1; then
    echo 'Install the stable Rust toolchain from https://rustup.rs, reopen Terminal, and rerun this script.' >&2
    exit 1
fi
export MACOSX_DEPLOYMENT_TARGET="${MACOSX_DEPLOYMENT_TARGET:-11.0}"
cargo build --locked --release --target x86_64-apple-darwin --bin fcop
mkdir -p game_files
echo 'Build complete. Import your PC game files, then run ./launch.sh'

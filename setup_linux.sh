#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
if [[ "$(uname -s)" != Linux ]]; then
    echo 'Use setup_macos.sh on an Intel Mac.' >&2
    exit 1
fi
command -v cargo >/dev/null || { echo 'Install stable Rust from https://rustup.rs' >&2; exit 1; }
command -v pkg-config >/dev/null || { echo 'Install pkg-config, ALSA and udev development packages.' >&2; exit 1; }
pkg-config --exists alsa libudev || { echo 'Debian/Ubuntu: sudo apt install build-essential pkg-config libasound2-dev libudev-dev' >&2; exit 1; }
cargo build --locked --release --bin fcop
mkdir -p game_files
echo 'Build complete. Import your PC game files, then run ./launch.sh'

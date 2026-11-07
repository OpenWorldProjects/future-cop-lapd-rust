# Future Cop: L.A.P.D. — native Rust PC port

Personal source fork of [RadiatorTwo/future_rust_cop](https://github.com/RadiatorTwo/future_rust_cop), based on v0.5.0 (`545848b`). The original PC executable is recompiled locally with Cranelift. Windows services and rendering are implemented in Rust/OpenGL. Wine and PlayStation game files are not used.

This repository contains port source and build scripts. **Bring your own original PC game files.** No original executable, missions, textures, audio, movies, saves, CD images, or generated game-code cache is included.

## Intel macOS (experimental)

Targets the Intel 2015 15-inch MacBook Pro. Install Apple's command line tools (`xcode-select --install`) and stable Rust from [rustup.rs](https://rustup.rs), then:

```sh
git clone https://github.com/OpenWorldProjects/future-cop-lapd-rust.git
cd future-cop-lapd-rust
./setup_macos.sh
# Import your PC game files as described below.
./launch.sh
```

The macOS changes keep Cocoa on the main thread, reserve a 256 MiB main stack, and request OpenGL 4.1 core with GLSL 4.10. Intel macOS builds and game-independent tests run in GitHub Actions. A successful CI build does not verify gameplay, audio, controllers, or a particular patched macOS installation. Tahoe 26.7.1 on this MacBook remains unverified. Apple Silicon is outside this build's current scope.

Start at the display's default resolution and a 60 fps limit, then adjust Preferences in-game. The launcher does not force an ultrawide resolution or Linux display variables on your Mac.

## Linux

Install stable Rust and build dependencies (Debian/Ubuntu: `sudo apt install build-essential pkg-config libasound2-dev libudev-dev`), then run `./setup_linux.sh` and `./launch.sh`.

## Windows

Install stable Rust and Visual Studio C++ build tools, then `cargo build --locked --release --bin fcop`. Put copies of your game files in `target/release/game_files` and launch `target/release/fcop.exe`. CI builds and tests Windows too.

## Import your game

The supported `FCopLAPD.exe` SHA-256 is:

```text
2dcdd1e78b99947d125712e1a159548e6f5f3929020c29af9e156314ed1c7e5e
```

Both PC CDs checked during local setup (Europe and USA rerelease) contained that executable. For the Linux/macOS scripts, use this layout:

```text
game_files/
  FCopLAPD/
    FCopLAPD.exe
    febmp.bin
    missions/
  Video/
    *.mpg
```

Copy these from your PC CD or installation. Alternatively, copy a PC CD `.iso` or raw `.bin` image into `game_files/` and let the first launch extract it. **Only use copies:** upstream setup deletes unneeded files inside `game_files`, including the imported image. Keep your original downloads elsewhere. Do not use a symlink to your original installation. For archive downloads, extract the ZIP/7z first; those formats are not CD images.

Settings, controls, saves and locally compiled game code stay under `game_files`; they are ignored by Git. Copy that directory privately between computers if desired; the runtime refreshes an incompatible compilation cache. Never commit or publicly upload it.

## Local changes and status

Preserved local changes add D-pad movement, keyboard fallbacks, bicubic menu scaling, stretched widescreen menus with matching mouse coordinates, and HUD placement adjustments. The keyboard fallback has overlapping bindings (for example S for backward movement and targeting); this behavior is inherited from the local changes and may need refinement.

Upstream implements high-resolution widescreen rendering, integrated Preferences, gamepads, TCP/IP multiplayer, video playback, and optional replacement textures. This fork does not provide redesigned assets or claim full-game completion testing. See [UPSTREAM-README.md](UPSTREAM-README.md) for upstream behavior; its screenshot links refer to files omitted from this source-only fork.

## License and distribution

The port is under the upstream [MIT license](LICENSE), copyright RadiatorTwo. Its MPEG decoder derives from pl_mpeg by Dominic Szablewski, with audio based on kjmp2 by Martin J. Fiedler; the upstream attribution is retained. Dependencies retain their own licenses. The optional `difftest` feature uses GPL-2.0 Unicorn and is not enabled or linked into normal game builds.

The MIT license applies to port code, not the original game's proprietary code, art, music, missions or branding. Remastering or modifying those resources does not grant redistribution permission. This source-only arrangement is not a legal determination about every use or jurisdiction. Public packages must exclude game data, generated game-code caches and private saves.

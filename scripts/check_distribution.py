"""Reject game resources/caches and binaries in the tracked source distribution."""
import pathlib
import subprocess

root = pathlib.Path(__file__).resolve().parents[1]
names = subprocess.check_output(
    ["git", "ls-files", "-z"], cwd=root
).decode().split("\0")
blocked = []
suffixes = {".exe", ".dll", ".iso", ".cue", ".bin", ".zip", ".7z", ".mpg", ".wav", ".cfg", ".png"}
for name in filter(None, names):
    path = pathlib.Path(name)
    if any(part in {"game_files", "target", "shot"} for part in path.parts) and name != "dist/game_files/README.txt":
        blocked.append(name)
    elif path.suffix.lower() in suffixes:
        blocked.append(name)
    elif (root / path).is_file():
        with (root / path).open("rb") as stream:
            magic = stream.read(4)
        if magic.startswith((b"MZ", b"\x7fELF", b"PK\x03\x04")) or magic in {b"\xcf\xfa\xed\xfe", b"\xfe\xed\xfa\xcf"}:
            blocked.append(name)
if blocked:
    raise SystemExit("Excluded distribution files tracked:\n" + "\n".join(blocked))
print("Source distribution check passed; no recognized game resources, caches or binaries tracked.")

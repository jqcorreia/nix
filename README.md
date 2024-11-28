# nix

# Laptop (vertex)

Problems:
- Whatsapp get funky after browser restart
- SDDM asks second time for the password after a reboot, probably PAM
- icon theme not set, dunno why
- Unstable errors:
    - hyprland - 0.45

Solved:
- using nix-shell inside a rust project with rust analizer changes env vars resulting in recompilation of packages (e.g ring and rusttls). See Rust instruction below.
- Vivaldi unstable - needed installation of `mesa` unstable because of libgbm
- sometimes blueman manager doesn't open from the applet due to, it seems, some dbus stuff that needs to happen
    - upon a hyprland restart dbus must be updated. See script `import_envs.sh`

# Rust
Use `rustup` nix package and manually install toolchain and rust-analyzer
- `rustup toolchain install stable-x86_64-unknown-linux-gnu`
- `rustup component add rust-analyzer`

Create a `shell.nix` file stating the runtime dependencies (if you have them) and build it from there

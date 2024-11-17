# nix

# Laptop (vertex)

Problems:
- Whatsapp get funky after browser restart
- SDDM asks second time for the password after a reboot, probably PAM
- icon theme not set, dunno why
- sometimes blueman manager doesn't open from the applet due to, it seems, some dbus stuff that needs to happen
- Unstable errors:
    - vivaldi
    - hyprland

Solved:
- using nix-shell inside a rust project with rust analizer changes env vars resulting in recompilation of packages (e.g ring and rusttls). Installing the packages `cargo` and `rust-analyzer` inside the shell solves this. Should not use `rustup`


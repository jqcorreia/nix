{ pkgs, unstable, ... }:
{
  programs.adb.enable = true;
  users.users.jqcorreia = {
    extraGroups = [ "adbusers" ];
  };

  config = {
    environment.systemPackages = with pkgs; [
      bat
      wget
      chezmoi
      git
      git-lfs
      git-cliff
      tmux
      nodejs
      jq
      rclone
      gcc
      go
      (pkgs.pass-wayland.withExtensions (exts: [ exts.pass-otp ]))
      lshw
      unzip
      pritunl-client
      SDL2
      SDL2_ttf
      SDL2_image
      ripgrep
      (python312.withPackages (ps: with ps; [ requests ]))
      pipx
      nixfmt-rfc-style
      gcr
      home-manager
      dig
      libsForQt5.qt5.qtgraphicaleffects
      nix-prefetch
      terraform
      bitwarden-cli
      unstable.mesa
      unstable.vivaldi
      socat
      btop
      fd
      wireguard-tools
      ffmpeg
      mpv
      glfw
      hyprlock
      libinput
      devenv
    ];
  };
}

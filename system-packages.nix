{ pkgs, unstable, ... }:
{
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
      lua-language-server
      python312
      pipx
      nil
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
      jq-lsp
    ];
  };
}

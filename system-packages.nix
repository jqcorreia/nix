{ pkgs, unstable, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      bat
      wget
      chezmoi
      git
      git-lfs
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
      unstable.ruff-lsp
      unstable.pyright
      unstable.neovim
      unstable.terraform-ls
      nil
      nixfmt-rfc-style
      gcr
      home-manager
      dig
      libsForQt5.qt5.qtgraphicaleffects
      nix-prefetch
      terraform
      bitwarden-cli
      vivaldi
      waybar
    ];
  };
}

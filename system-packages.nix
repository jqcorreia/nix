{ pkgs, unstable, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      bat
      wget
      chezmoi
      git
      git-lfs
      alacritty
      tmux
      nodejs
      jq
      waybar
      rclone
      gcc
      go
      (pkgs.pass-wayland.withExtensions (exts: [ exts.pass-otp ]))
      lshw
      unzip
      pavucontrol
      networkmanagerapplet
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
      vivaldi
      nil
      nixfmt-rfc-style
      gcr
      home-manager
      phinger-cursors
      sddm
    ];
  };
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    feh
    smplayer
    networkmanagerapplet
    pavucontrol
    phinger-cursors
  ];

  programs.waybar = {
    enable = true;
    style = builtins.readFile ./.config/waybar/style.css;
  };

  # Don't know why but installing waybar via home packages has a zero bytes SDL2 lib
  home.file = {
    "./.config/waybar/config.jsonc".text = builtins.readFile ./.config/waybar/config.jsonc;
  };
}

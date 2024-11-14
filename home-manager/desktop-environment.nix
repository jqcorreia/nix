{ pkgs }:

{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    feh
    smplayer
    networkmanagerapplet
    pavucontrol
    vivaldi
    phinger-cursors
  ];

  programs.waybar = {
    enable = true;
    settings = builtins.readFile ./.config/waybar/config.jsonc;
    styles = builtins.readFile ./.config/waybar/styles.css;
  };
}

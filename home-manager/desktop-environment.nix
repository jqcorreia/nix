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

  # programs.waybar = {
  #   enable = true;

  #   # Need to set settings directly by file since JSONC isn't supported and we don't 
  #   # want to miss the comments capacity
  #   style = builtins.readFile ./.config/waybar/style.css;
  # };

  home.file = {
    "./.config/waybar/config.jsonc".text = builtins.readFile ./.config/waybar/config.jsonc;
    "./.config/waybar/style.css".text = builtins.readFile ./.config/waybar/style.css;
  };
}

{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = builtins.fromTOML ''
      [env]
      TERM = "xterm-256color"

      [font]
      size = 10

      [font.normal]
      family = "DejaVuSansM Nerd Font" # Make sure to add 'nerdfonts' to the fonts.packages in configuration.nix

      [window]
      opacity = 0.85
    '';
  };
}

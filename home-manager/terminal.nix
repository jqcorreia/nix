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
      family = "DejaVuSansM Nerd Font"

      [window]
      opacity = 0.85
    '';
  };
}

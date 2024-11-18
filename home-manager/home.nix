{ pkgs, ... }:

{
  imports = [
    ./terminal.nix
    ./user-shell.nix
    ./desktop-environment.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jqcorreia";
  home.homeDirectory = "/home/jqcorreia";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    gnumake
    fzf
    grim
    slurp
    wl-clipboard
    poetry
    awscli2
    feh
    smplayer
    rustup
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # This will set the mouse cursor default for all applications
    # ".local/share/icons/default/index.theme".text = ''
    #   [Icon Theme]
    #   Inherits=phinger-cursors-dark
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services.dunst = {
    enable = true;
    settings = {
      global = {
        transparency = 9;
      };
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Fluent";
      package = pkgs.fluent-gtk-theme;
    };
  };
}

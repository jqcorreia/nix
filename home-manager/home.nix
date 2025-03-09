{
  pkgs,
  config,
  ghostty,
  unstable,
  ...
}:
let
  odin_updated = pkgs.odin.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "dev-2025-01";
      src = pkgs.fetchFromGitHub {
        owner = "odin-lang";
        repo = "Odin";
        rev = "2aae4cfd461860bd10dcb922f867c98212a11449";
        hash = "sha256-GXea4+OIFyAhTqmDh2q+ewTUqI92ikOsa2s83UH2r58=";
      };
    }
  );
in
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
    # unstable.poetry
    # unstable.poetryPlugins.poetry-plugin-shell
    awscli2
    feh
    smplayer
    rustup
    pkg-config
    d-spy
    tree-sitter
    ghostty.packages.x86_64-linux.default
    unstable.firefox
    unstable.google-chrome
    ranger
    cloc
    odin_updated
    conftest
    unstable.ruff
    gopls
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim/" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/jqcorreia/nix/home-manager/nvim/";
      recursive = true;
    };
    ".config/tmux/import_envs.sh".source = ./import_envs.sh;

    # This will set the mouse cursor default for all applications
    ".local/share/icons/default/index.theme".text = ''
      [Icon Theme]
      Inherits=phinger-cursors-dark
    '';
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
    # theme = {
    #   name = "Breeze-Dark";
    #   package = pkgs.libsForQt5.breeze-gtk;
    # };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders;
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Light-Cursors";
      package = pkgs.catppuccin-cursors.mochaLight;
    };
  };
}

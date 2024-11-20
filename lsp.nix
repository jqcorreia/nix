{ pkgs, unstable, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      unstable.ruff-lsp
      unstable.pyright
      unstable.neovim
      unstable.clang-tools
    ];
  };
}

{ pkgs, unstable, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      unstable.ruff-lsp
      unstable.pyright
      unstable.neovim
      unstable.clang-tools
      unstable.ols
      unstable.typescript-language-server
      lua-language-server
      nil
      vscode-langservers-extracted
    ];
  };
}

{ pkgs, unstable, ... }:
{
  home.packages = with pkgs; [
    unstable.pyright
    unstable.neovim
    unstable.clang-tools
    unstable.ols
    unstable.typescript-language-server
    lua-language-server
    nil
    vscode-langservers-extracted
    unstable.ruff
    unstable.gopls
    unstable.glsl_analyzer
  ];

}

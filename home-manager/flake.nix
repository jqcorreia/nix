{
  description = "Home Manager configuration of jqcorreia";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:youwen5/zen-browser-flake";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      zen-browser,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      legacyPackages =
        nixpkgs.lib.genAttrs
          [
            "x86_64-linux"
            "x86_64-darwin"
          ]
          (
            system:
            import inputs.unstable {
              inherit system;
              # NOTE: Using `nixpkgs.config` in your NixOS config won't work
              # Instead, you should set nixpkgs configs here
              # (https://nixos.org/manual/nixpkgs/stable/#idm140737322551056)

              config.allowUnfree = true;
            }
          );
    in
    {
      homeConfigurations."jqcorreia" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          unstable = legacyPackages.x86_64-linux;
          inputs = inputs;
        };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}

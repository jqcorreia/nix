{
  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
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
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = {
          unstable = legacyPackages.x86_64-linux;
        };
        modules =
          let
            common = {
              nix.registry.nixpkgs.flake = nixpkgs;
            };
          in
          [
            common
            ./configuration.nix
            inputs.home-manager.nixosModules.default
          ];
      };
    };
}

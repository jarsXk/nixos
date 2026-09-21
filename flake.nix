{
  description = "My NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, disko, ... }:
    let

      mkSystem = hostname:
        let
          machine = import ./machines/${hostname}/machine.nix;
        in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            inherit machine;
          };

          modules = [
            disko.nixosModules.disko

            ./modules/configuration.nix
            ./modules/disko.nix

            ./machines/${hostname}/hardware.nix
          ];
        };

    in {
      nixosConfigurations = {
        nixmatevm = mkSystem "nixmatevm";
        nixgnomevm = mkSystem "nixgnomevm";
      };
    };
}
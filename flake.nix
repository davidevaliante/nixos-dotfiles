{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      linux_64 = "x86_64-linux";

      # Helper function to create a NixOS system
      mkHost = system: hostname: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/${hostname}/configuration.nix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.davide = import ./users/davide/home.nix;
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        # Existing host
        hydrogen = mkHost linux_64 "hydrogen";

        # Add new hosts here following the same pattern:
        # hostname = mkHost "hostname" "system-architecture";
        # Example:
        # helium = mkHost "helium" "x86_64-linux";
        # carbon = mkHost "carbon" "aarch64-linux";
      };
    };
}


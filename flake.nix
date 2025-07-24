{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      linux_64 = "x86_64-linux";
      # Helper function to create a NixOS system
      mkHost = system: hostname: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/${hostname}/configuration.nix
        ];
      };
    in
    {
      nixosConfigurations = {
        # Existing host
        hydrogen = mkHost linux_64 "hydrogen";
        helium = mkHost linux_64 "helium";

        # Add new hosts here following the same pattern:
        # hostname = mkHost "hostname" "system-architecture";
        # Example:
        # helium = mkHost "helium" "x86_64-linux";
        # carbon = mkHost "carbon" "aarch64-linux";
      };
    };
}


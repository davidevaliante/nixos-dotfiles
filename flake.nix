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
          home-manager.nixosModules.home-manager
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
        # VM configuration
        hydrogen-vm = mkHost linux_64 "hydrogen-vm";

        # NVIDIA configuration  
        hydrogen-nvidia = mkHost linux_64 "hydrogen-nvidia";

        # Default (currently VM)
        hydrogen = mkHost linux_64 "hydrogen-vm";
        
        # Helium configuration (current hostname)
        helium = mkHost linux_64 "hydrogen";
      };
    };
}


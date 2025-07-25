{ config, pkgs, ... }:

{
  # Enable Nix Flakes
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    
    # Binary caches
    substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
    ];
    
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System state version
  system.stateVersion = "25.05";

  # Allow davide to run nixos-rebuild without password
  security.sudo.extraRules = [
    {
      users = [ "davide" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
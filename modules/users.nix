{ config, pkgs, ... }:

{
  # Define user davide
  users.users.davide = {
    isNormalUser = true;
    description = "Davide";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # User-specific packages can be added here
    ];
  };

  # Enable sudo for wheel group
  security.sudo.wheelNeedsPassword = true;
}
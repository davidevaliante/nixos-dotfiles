{ config, pkgs, ... }:

{
  # Enable networking
  networking.networkmanager.enable = true;

  # Common firewall settings
  networking.firewall = {
    enable = true;
    # Common allowed TCP ports can be defined here
    # allowedTCPPorts = [ ];
    # allowedUDPPorts = [ ];
  };
}
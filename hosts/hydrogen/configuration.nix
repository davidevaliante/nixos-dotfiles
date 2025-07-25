{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/users.nix
    ../../modules/networking.nix
    ../../modules/localization.nix
    ../../modules/packages.nix
    ../../modules/services/ssh.nix
    ../../modules/services/nvidia.nix
    ../../modules/services/hyprland.nix
  ];

  # Host-specific configuration
  networking.hostName = "hydrogen";

  # Boot loader configuration (host-specific)
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  # Any host-specific overrides or additional configuration can go here
}
{ config, pkgs, ... }:

{
  imports = [
    ../hydrogen/hardware-configuration.nix  # You'll need to update this for your actual hardware
    ../../modules/common.nix
    ../../modules/users.nix
    ../../modules/networking.nix
    ../../modules/localization.nix
    ../../modules/packages.nix
    ../../modules/services/ssh.nix
    ../../modules/hardware/nvidia.nix
    ../../modules/services/hyprland-unified.nix
  ];

  # Host-specific configuration
  networking.hostName = "hydrogen";

  # Boot loader configuration for actual hardware
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";  # Update this for your actual device
    useOSProber = true;
  };

  # NVIDIA-specific optimizations can go here
}
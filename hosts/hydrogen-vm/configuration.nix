{ config, pkgs, ... }:

{
  imports = [
    ../hydrogen/hardware-configuration.nix  # Reuse the same hardware config
    ../../modules/common.nix
    ../../modules/users.nix
    ../../modules/networking.nix
    ../../modules/localization.nix
    ../../modules/packages.nix
    ../../modules/services/ssh.nix
    ../../modules/hardware/vm.nix
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

  # VM-specific optimizations
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
}
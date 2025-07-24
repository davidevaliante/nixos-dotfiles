# wsl configuration for prototyping. Doesn't need hardware-configuration.nix

{ config, pkgs, ... }:

{
  imports = [
    <nixos-wsl/modules>
    ../../modules/common.nix
    ../../modules/users.nix
    ../../modules/networking.nix
    ../../modules/localization.nix
    ../../modules/packages.nix
    ../../modules/services/ssh.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "davide";
  };

  # Host-specific configuration
  networking.hostName = "helium";

  # Any host-specific overrides or additional configuration can go here
}

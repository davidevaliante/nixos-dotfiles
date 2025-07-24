{ config, pkgs, ... }:

{
  imports = [
    ./modules/packages.nix
    ./modules/git.nix
    ./modules/shell.nix
    ./modules/development.nix
  ];

  home.username = "davide";
  home.homeDirectory = "/home/davide";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}

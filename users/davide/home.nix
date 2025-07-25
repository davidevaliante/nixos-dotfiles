{ config, pkgs, ... }:

{
  imports = [
    ./modules/packages.nix
    ./modules/git.nix
    ./modules/shell.nix
    ./modules/development.nix
    ./modules/wezterm.nix
    ./modules/starship.nix
    ./modules/programming_languages.nix
    ./modules/hyprland.nix
  ];

  home.username = "davide";
  home.homeDirectory = "/home/davide";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}

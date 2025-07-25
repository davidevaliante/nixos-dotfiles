{ config, pkgs, lib, ... }:

{
  imports = [
    ./bash.nix
    ./zsh.nix
    ./aliases.nix
    ./environment.nix
  ];
}
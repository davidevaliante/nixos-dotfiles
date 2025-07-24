{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # system tools
    neofetch
  ];
}


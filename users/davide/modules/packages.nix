{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # system tools
    neofetch

    # development tools
    terraform

    # fonts
    nerd-fonts._0xproto
  ];
}


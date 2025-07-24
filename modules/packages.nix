{ config, pkgs, ... }:

{
  # List of common packages to install system-wide
  environment.systemPackages = with pkgs; [
    # Version control
    git

    # Text editors
    neovim

    # System utilities
    btop
    wget
    curl
    tree
    which
  ];
}


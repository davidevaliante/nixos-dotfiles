{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Development tools
    # Uncomment the tools you need:

    # # Version control
    # gh # GitHub CLI
    # lazygit # Terminal UI for git

    # # Languages and runtimes
    # nodejs_20
    # python3
    # go
    # rustc
    # cargo

    # # Build tools
    # gnumake
    # cmake
    # gcc

    # # Containers
    # docker
    # docker-compose
    # podman
  ];
}


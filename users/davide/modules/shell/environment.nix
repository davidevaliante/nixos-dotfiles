{ config, pkgs, lib, ... }:

{
  home.sessionPath = [
    "/opt/nvim-linux64/bin"
    "$HOME/bin"
    "/usr/local/go/bin"
    "/home/davide/.local/bin"
    "$PNPM_HOME"
    "$BUN_INSTALL/bin"
    "$HOME/go/bin"
    "$HOME/.local/bin"
    "$(go env GOPATH)/bin"
    "/snap/bin"
    "$HOME/.tofuenv/bin"
    "/usr/local/cuda-11.2/bin"
    "/home/davide/.pulumi/bin"
  ];
}
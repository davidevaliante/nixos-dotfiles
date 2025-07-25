{ config, pkgs, lib, ... }:

{
  # Common shell aliases shared between bash and zsh
  programs.bash.shellAliases = {
    # Navigation
    ll = "ls -l";
    la = "ls -la";
    ".." = "cd ..";
    "..." = "cd ../..";
  };

  programs.zsh.shellAliases = {
    # Navigation (common)
    ll = "ls -l";
    la = "ls -la";
    ".." = "cd ..";
    "..." = "cd ../..";
    
    # Zsh-specific navigation with eza and zoxide
    ls = "eza -1l --icons";
    zz = "z ..";
    zzz = "z ../../";

    # Git aliases
    gaa = "git add .";
    gac = "git add . && echo -n \"Commit msg: \" && read msg && git commit -m \"$msg\"";

    # General aliases
    cleanswap = "sudo rm -r ~/.local/state/nvim/swap/";
    nvim-settings = "cd ~/.config/nvim && nvim .";

    # Program aliases
    air = "~/go/bin/air";
    tofu = "tofu-command";
    claude = "/home/davide/.claude/local/claude";
    
    # NixOS rebuild alias with automatic hostname detection
    rebuild = "sudo /run/current-system/sw/bin/nixos-rebuild switch --flake .#$(hostname)";
  };
}
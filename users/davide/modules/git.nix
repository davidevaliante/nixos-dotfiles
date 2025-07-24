{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Davide Valiante";
    userEmail = "dav.valiante@gmail.com";
    
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
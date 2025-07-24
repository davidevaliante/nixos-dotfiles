{ config, pkgs, ... }:

{
  # Enable the OpenSSH daemon
  services.openssh = {
    enable = true;
    settings = {
      # Security settings
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      # Add more SSH settings as needed
    };
  };
}
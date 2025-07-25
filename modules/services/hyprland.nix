{ config, pkgs, lib, ... }:

{
  # Unified Hyprland configuration that works for both VM and NVIDIA

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable the display manager
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  # Enable dbus
  services.dbus.enable = true;

  # XDG portal for screen sharing and file picking
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  # Essential packages for Hyprland
  environment.systemPackages = with pkgs; [
    # Terminal emulators
    wezterm
    foot # Lightweight fallback terminal

    # Notifications
    dunst
    libnotify

    # Wallpaper
    hyprpaper

    # App launcher
    rofi-wayland

    # Status bar
    waybar

    # Screenshot utility
    grimblast

    # Screen recording
    wf-recorder

    # Clipboard manager
    wl-clipboard
    cliphist

    # Authentication agent
    polkit_gnome

    # File manager
    nautilus

    # System tray
    networkmanagerapplet

    # Brightness control
    brightnessctl

    # Audio control
    pavucontrol
    playerctl

    # Lock screen
    swaylock-effects
  ];

  # Enable sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Polkit authentication agent
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # Common session variables
  environment.sessionVariables = {
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";

    # GTK theme
    GTK_USE_PORTAL = "1";
  };
}


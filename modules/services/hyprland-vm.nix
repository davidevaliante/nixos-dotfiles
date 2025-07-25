{ config, pkgs, lib, ... }:

{
  # Enable Hyprland with VM-friendly settings
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Use software rendering for VM
  environment.sessionVariables = {
    # Force software rendering
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    
    # Disable GPU acceleration
    __GLX_VENDOR_LIBRARY_NAME = "mesa";
    GBM_BACKEND = "dri";
    
    # Use software OpenGL
    LIBGL_ALWAYS_SOFTWARE = "1";
    
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    
    # GTK theme
    GTK_USE_PORTAL = "1";
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
    foot  # Lightweight terminal that works well in VMs
    
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
    
    # Mesa utilities for debugging
    mesa-demos
    glxinfo
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

  # Software rendering for Mesa
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      mesa.drivers
    ];
  };
}
{ config, pkgs, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    
    settings = {
      # Monitor configuration
      monitor = [
        # Default monitor configuration
        ",preferred,auto,1"
      ];

      # General settings
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      # Decoration settings
      decoration = {
        rounding = 10;
        
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      # Animation settings
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # Input configuration
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        
        touchpad = {
          natural_scroll = false;
        };
        
        sensitivity = 0;
      };

      # Dwindle layout settings
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Master layout settings
      master = {
        new_status = "master";
      };

      # Gestures
      gestures = {
        workspace_swipe = false;
      };

      # Misc settings
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = true;
      };

      # Cursor configuration for NVIDIA
      cursor = {
        no_hardware_cursors = true;
        allow_dumb_copy = true;
      };

      # Window rules
      windowrulev2 = [
        # Make some windows floating by default
        "float,class:^(pavucontrol)$"
        "float,class:^(nm-connection-editor)$"
        "float,class:^(nautilus)$"
        "float,title:^(Picture-in-Picture)$"
        
        # Firefox picture-in-picture
        "float,title:^(Picture-in-Picture)$"
        "pin,title:^(Picture-in-Picture)$"
        "move 69% 4%,title:^(Picture-in-Picture)$"
        "size 30% 30%,title:^(Picture-in-Picture)$"
      ];

      # Keybindings
      "$mod" = "SUPER";
      
      bind = [
        # Basic bindings
        "$mod, RETURN, exec, wezterm"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, nautilus"
        "$mod, V, togglefloating,"
        "$mod, R, exec, rofi -show drun"
        "$mod, P, pseudo,"
        "$mod, J, togglesplit,"
        "$mod, F, fullscreen,"
        
        # Move focus with mod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        
        # Move focus with mod + hjkl
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        
        # Switch workspaces with mod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        
        # Move active window to a workspace with mod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        
        # Scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        
        # Screenshot bindings
        ", Print, exec, grimblast copy area"
        "SHIFT, Print, exec, grimblast copy screen"
        
        # Volume control
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        
        # Brightness control
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        
        # Lock screen
        "$mod, L, exec, swaylock"
      ];
      
      # Mouse bindings
      bindm = [
        # Move/resize windows with mod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Autostart applications
      exec-once = [
        "waybar"
        "hyprpaper"
        "dunst"
        "nm-applet --indicator"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];
    };
  };

  # Hyprland packages for home-manager
  home.packages = with pkgs; [
    # Hyprland utilities
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
  ];

  # Waybar configuration
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "network" "cpu" "memory" "battery" "tray" ];
        
        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            urgent = "";
            active = "";
            default = "";
          };
        };
        
        clock = {
          format = "{:%Y-%m-%d %H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        
        cpu = {
          format = " {usage}%";
          tooltip = false;
        };
        
        memory = {
          format = " {}%";
        };
        
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };
        
        network = {
          format-wifi = " {signalStrength}%";
          format-ethernet = " {ipaddr}";
          format-disconnected = "⚠ Disconnected";
          tooltip-format = "{ifname}: {ipaddr}";
        };
        
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " Muted";
          format-icons = {
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };
      };
    };
    
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrains Mono", monospace;
        font-size: 13px;
        min-height: 0;
      }
      
      window#waybar {
        background: rgba(21, 18, 27, 0.8);
        color: #cdd6f4;
      }
      
      #workspaces button {
        padding: 0 5px;
        background: transparent;
        color: #cdd6f4;
        border-bottom: 3px solid transparent;
      }
      
      #workspaces button.active {
        background: #313244;
        border-bottom: 3px solid #89b4fa;
      }
      
      #clock,
      #battery,
      #cpu,
      #memory,
      #network,
      #pulseaudio,
      #tray {
        padding: 0 10px;
        margin: 0 5px;
      }
      
      #battery.charging {
        color: #a6e3a1;
      }
      
      #battery.warning:not(.charging) {
        color: #f9e2af;
      }
      
      #battery.critical:not(.charging) {
        color: #f38ba8;
      }
    '';
  };

  # Rofi configuration
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = "Arc-Dark";
    extraConfig = {
      modi = "run,drun,window";
      show-icons = true;
      terminal = "wezterm";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 﩯  Window";
      sidebar-mode = true;
    };
  };

  # Dunst notification daemon
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        width = 300;
        height = 300;
        origin = "top-right";
        offset = "10x50";
        scale = 0;
        notification_limit = 0;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        indicate_hidden = "yes";
        transparency = 0;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        text_icon_padding = 0;
        frame_width = 3;
        frame_color = "#89b4fa";
        separator_color = "frame";
        sort = "yes";
        font = "JetBrains Mono 10";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";
        icon_position = "left";
        min_icon_size = 0;
        max_icon_size = 32;
        sticky_history = "yes";
        history_length = 20;
        always_run_script = true;
        corner_radius = 10;
        ignore_dbusclose = false;
        force_xwayland = false;
        force_xinerama = false;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };
      
      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        timeout = 10;
      };
      
      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        timeout = 10;
      };
      
      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#f38ba8";
        timeout = 0;
      };
    };
  };
}
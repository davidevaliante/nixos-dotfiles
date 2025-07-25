{ config, pkgs, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    
    settings = {
      # Monitor configuration for VM
      monitor = [
        # Use a lower resolution for better VM performance
        ",preferred,auto,1"
      ];

      # VM-specific environment variables
      env = [
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "WLR_NO_HARDWARE_CURSORS,1"
        "LIBGL_ALWAYS_SOFTWARE,1"
      ];

      # General settings - reduced for VM performance
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      # Simplified decoration for VM
      decoration = {
        rounding = 5;
        
        blur = {
          enabled = false;  # Disable blur for better VM performance
          size = 3;
          passes = 1;
        };
        
        drop_shadow = false;  # Disable shadows for better VM performance
      };

      # Simplified animations for VM
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        
        animation = [
          "windows, 1, 3, myBezier"
          "windowsOut, 1, 3, default, popin 80%"
          "border, 1, 5, default"
          "fade, 1, 3, default"
          "workspaces, 1, 3, default"
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
        vfr = false;  # Disable variable refresh rate for VM
      };

      # Debug settings for VM
      debug = {
        damage_tracking = 2;  # Full damage tracking for software rendering
        disable_logs = false;
        disable_time = false;
      };

      # Window rules
      windowrulev2 = [
        # Make some windows floating by default
        "float,class:^(pavucontrol)$"
        "float,class:^(nm-connection-editor)$"
        "float,class:^(nautilus)$"
        "float,title:^(Picture-in-Picture)$"
      ];

      # Keybindings
      "$mod" = "SUPER";
      
      bind = [
        # Basic bindings - using foot as fallback terminal
        "$mod, RETURN, exec, foot || wezterm"
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
        # Skip hyprpaper in VM for performance
        "dunst"
        "nm-applet --indicator"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];
    };
  };

  # Rest of the configuration remains the same...
  home.packages = with pkgs; [
    # Hyprland utilities
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    
    # Add foot terminal as fallback
    foot
  ];

  # Waybar configuration (simplified for VM)
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "cpu" "memory" "tray" ];
        
        "hyprland/workspaces" = {
          format = "{id}";
          on-click = "activate";
        };
        
        clock = {
          format = "{:%Y-%m-%d %H:%M}";
        };
        
        cpu = {
          format = "CPU: {usage}%";
          interval = 2;
        };
        
        memory = {
          format = "MEM: {}%";
          interval = 2;
        };
      };
    };
    
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: monospace;
        font-size: 13px;
        min-height: 0;
      }
      
      window#waybar {
        background: rgba(0, 0, 0, 0.8);
        color: #ffffff;
      }
      
      #workspaces button {
        padding: 0 5px;
        background: transparent;
        color: #ffffff;
        border-bottom: 3px solid transparent;
      }
      
      #workspaces button.active {
        background: #64727D;
        border-bottom: 3px solid #ffffff;
      }
      
      #clock,
      #cpu,
      #memory,
      #tray {
        padding: 0 10px;
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
      terminal = "foot";
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
        transparency = 0;
        padding = 8;
        horizontal_padding = 8;
        frame_width = 2;
        frame_color = "#aaaaaa";
        separator_color = "frame";
        font = "Monospace 10";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\n%b";
        alignment = "left";
        show_age_threshold = 60;
        word_wrap = "yes";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";
        icon_position = "left";
        max_icon_size = 32;
        sticky_history = "yes";
        history_length = 20;
        corner_radius = 0;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };
      
      urgency_low = {
        background = "#222222";
        foreground = "#888888";
        timeout = 10;
      };
      
      urgency_normal = {
        background = "#285577";
        foreground = "#ffffff";
        timeout = 10;
      };
      
      urgency_critical = {
        background = "#900000";
        foreground = "#ffffff";
        frame_color = "#ff0000";
        timeout = 0;
      };
    };
  };
}
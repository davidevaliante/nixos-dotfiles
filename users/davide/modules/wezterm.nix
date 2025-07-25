{ config, pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = /* lua */ ''
      -- Pull in the wezterm API
      local wezterm = require("wezterm")
      local act = wezterm.action

      -- This table will hold the configuration.
      local config = {}
      -- local bg_color = "#171B20"
      local bg_color = "#161616"


      -- In newer versions of wezterm, use the config_builder which will
      -- help provide clearer error messages
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      -- COLOR SCHEME
      config.color_scheme = "Oxocarbon Dark (Gogh)"
      -- config.color_scheme = "Dracula (base16)"
      config.tab_bar_at_bottom = true
      config.use_fancy_tab_bar = false
      config.hide_tab_bar_if_only_one_tab = true

      config.colors = {
        -- bright green
        cursor_bg = "#2dfa48",

        -- bright pink
        -- cursor_bg = "#fa2dfa",

        -- oxocarbon
        -- cursor_bg = "#db2777",

        -- padding fix
        background = bg_color,
        tab_bar = {
          background = bg_color,
          active_tab = {
            bg_color = bg_color,
            fg_color = '#5eb56a',
            intensity = 'Bold',
          },

          inactive_tab = {
            bg_color = bg_color,
            fg_color = '#424242',
          },

          new_tab = {
            bg_color = bg_color,
            fg_color = '#d9a250',
          },
        },
      }

      -- config.window_background_opacity = 0.95
      -- config.win32_system_backdrop = 'Mica'
      -- config.win32_system_backdrop = 'Tabbed'
      -- config.win32_system_backdrop = 'Acrylic'

      -- Window frame configuration (only needed if decorations are enabled)
      -- config.window_frame = {
      --   active_titlebar_bg = "#ed1cab",
      --   inactive_titlebar_bg = "#ed1cab",
      --   font_size = 14.0,
      -- }

      -- FONTS RENDERING
      -- font is available at https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/SourceCodePro.zip (Select the bold font)
      config.font = wezterm.font_with_fallback({
        { family = "0xProto Nerd Font Mono" },
      })

      -- KEYMAPS

      -- GENERAL
      config.default_cwd = "/home/davide"

      -- disables the bell
      config.audible_bell = "Disabled"
      
      -- Remove title bar completely
      config.window_decorations = "RESIZE"
      config.skip_close_confirmation_for_processes_named = {
        "bash",
        "zsh",
        "fish",
      }
      -- style
      config.window_padding = {
        left = "8px",
        right = "8px",
        top = 0,
        bottom = 0,
      }
      -- config.window_background_opacity = 0.68

      config.keys = {
        -- paste from the clipboard
        { key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },

        -- paste from the primary selection
        { key = "V", mods = "CTRL", action = act.PasteFrom("PrimarySelection") },
      }

      -- enables kitty graphics
      config.enable_kitty_graphics = true

      -- and finally, return the configuration to wezterm
      return config
    '';
  };
}


{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = ''
        [╭─](bold green)$username$hostname$directory$git_branch$git_status$cmd_duration
        [╰─](bold green)$character
      '';

      username = {
        show_always = true;
        style_user = "bold blue";
        style_root = "bold red";
        format = "[$user]($style) ";
      };

      hostname = {
        ssh_only = false;
        format = "[@$hostname](bold yellow) ";
        disabled = false;
      };

      directory = {
        style = "bold cyan";
        format = "[$path]($style) ";
        truncation_length = 3;
        truncate_to_repo = true;
      };

      git_branch = {
        style = "bold purple";
        format = "[$symbol$branch]($style) ";
        symbol = " ";
      };

      git_status = {
        style = "bold red";
        format = "[$all_status$ahead_behind]($style) ";
      };

      cmd_duration = {
        min_time = 500;
        format = "[$duration](bold yellow) ";
      };

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };

      aws = {
        disabled = true;
      };

      gcloud = {
        disabled = true;
      };

      kubernetes = {
        disabled = false;
        format = "[$symbol$context( \\($namespace\\))]($style) ";
      };

      docker_context = {
        format = "[$symbol$context]($style) ";
      };

      python = {
        format = "[$symbol$pyenv_prefix($version )(\\($virtualenv\\) )]($style)";
        symbol = " ";
      };

      nodejs = {
        format = "[$symbol($version )]($style)";
        symbol = " ";
      };

      rust = {
        format = "[$symbol($version )]($style)";
        symbol = " ";
      };

      golang = {
        format = "[$symbol($version )]($style)";
        symbol = " ";
      };

      package = {
        format = "[$symbol$version]($style) ";
      };

      nix_shell = {
        format = "[$symbol$state( \\($name\\))]($style) ";
        symbol = " ";
      };

      memory_usage = {
        disabled = false;
        threshold = 80;
        format = "[$symbol$ram_pct]($style) ";
      };

      time = {
        disabled = false;
        format = "[$time]($style) ";
        time_format = "%H:%M";
      };
    };
  };
}
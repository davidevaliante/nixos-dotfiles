{ config, pkgs, lib, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
  };

  programs.zsh = {
    enable = true;
    historySubstringSearch.enable = true;

    initContent = lib.mkMerge [
      # Early initialization (equivalent to initExtraFirst)
      (lib.mkOrder 500 /* bash */ ''
        # Set up zinit
        ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"

        if [ ! -d "$ZINIT_HOME" ]; then
          mkdir -p "$(dirname $ZINIT_HOME)"
          ${pkgs.git}/bin/git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
        fi

        source "''${ZINIT_HOME}/zinit.zsh"
      '')

      # General configuration (equivalent to initExtra)
      (lib.mkOrder 1000 /* bash */ ''
        # Load zinit plugins
        zinit light zsh-users/zsh-syntax-highlighting
        zinit light zsh-users/zsh-autosuggestions

        # Additional history options
        setopt hist_save_no_dups

        # Completion configuration
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

        # Custom functions
        tofu-command () {
          args=("$@")
          slackUser="Davide"
          slackToken="my-slacktoken"
          channelID="C03T3NFSWHZ"

          curl -H "Content-type: application/json; charset=utf-8" -H "Authorization: Bearer $slackToken" "https://slack.com/api/chat.postMessage" -d "{\"channel\": \"$channelID\",\"text\": \":exclamation::exclamation::exclamation: $slackUser is running terraform :exclamation::exclamation::exclamation:\"}" > /dev/null 2>&1

          "tofu" "''${args[@]}"

          curl -H "Content-type: application/json; charset=utf-8" -H "Authorization: Bearer $slackToken" "https://slack.com/api/chat.postMessage" -d "{\"channel\": \"$channelID\",\"text\": \":white_check_mark: $slackUser finished running terraform\"}" > /dev/null 2>&1
        }

        function set-tab-title(){
          wezterm.exe cli set-tab-title $1
        }

        function dirswitch(){
          mkdir $1 && cd $1
        }

        # Source additional files
        [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
        eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"

        # Bun completions
        [ -s "/home/davide/.bun/_bun" ] && source "/home/davide/.bun/_bun"

        # NVM
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

        # Bash completion for terraform
        autoload -U +X bashcompinit && bashcompinit
        complete -o nospace -C ${pkgs.terraform}/bin/terraform terraform

        # Homebrew
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

        # Source wezterm
        source /home/davide/wezterm.sh
      '')
    ];

    shellAliases = {
      # Navigation
      ll = "ls -l";
      la = "ls -la";
      ".." = "cd ..";
      "..." = "cd ../..";
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
    };

    sessionVariables = {
      # Development
      GIT_EDITOR = "nvim";
      GOPRIVATE = "git-codecommit.eu-central-1.amazonaws.com";
      GOPROXY = "direct";

      # Tool paths
      PNPM_HOME = "/home/davide/.local/share/pnpm";
      BUN_INSTALL = "$HOME/.bun";

      # AI Configuration
      OUTPUT_DIR = "outputs";
      SEED_DATA = "false";
    };

  };

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


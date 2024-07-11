{ lib, config, pkgs, ... }: {
  options.rFeatures.tmux = {
    enable = lib.mkEnableOption "enables and configures tmux";
    withBattery = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description =
        "Whether to display the current battery charge level in tmux status bar.";
    };
  };

  config = lib.mkIf config.rFeatures.tmux.enable {
    home.packages = with pkgs; [ acpi ];
    home.file."${config.home.homeDirectory}/.local/bin".text = # bash
      ''
        #!/usr/bin/env bash
        # thanks prime

        selected=$(find ~/ | fzf)

        if [[ -z $selected ]]; then
        	exit 0
        fi

        selected_name=$(basename "$selected")

        if [[ -z $TMUX ]] && [[ -z $(pgrep tmux) ]]; then
        	tmux new-session -s "$selected_name" -c "$selected"
        	exit 0
        fi

        tmux new-session -A -s "$selected_name" -c "$selected" -d &> /dev/null
        tmux switch-client -t "$selected_name"
        # tmux switch-client -t "$(tmux new-session -APd -s "$selected_name" -c "$selected")"
      '';
    programs.tmux = {
      enable = true;
      terminal = "tmux-256color";
      keyMode = "vi";
      disableConfirmationPrompt = true;
      plugins = let
        basePlugins = with pkgs.tmuxPlugins; [ sensible vim-tmux-navigator ];
      in basePlugins ++ lib.optional config.rFeatures.tmux.withBattery {
        plugin = pkgs.tmuxPlugins.battery;
        extraConfig = # tmux
          ''
            set -g status-right '#{battery_color_status_fg}#[bg=default]#{battery_percentage}#[default] #h %H:%M %a %h-%d'
          '';
      };
      extraConfig = # tmux
        ''
          set -a terminal-features 'alacritty:RGB'
          set -g status on
          set -g status-position "top"
          set -g mouse on
          set -g status-left-length 20
          bind c new-window -c "#{pane_current_path}"
          bind '"' split-window -c "#{pane_current_path}"
          bind % split-window -h -c "#{pane_current_path}"
        '';
    };
  };
}

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
    programs.tmux = {
      enable = true;
      terminal = "tmux-256color";
      keyMode = "vi";
      disableConfirmationPrompt = true;
      plugins = let
        basePlugins = with pkgs.tmuxPlugins; [ sensible vim-tmux-navigator ];
      in basePlugins ++ lib.optional config.rFeatures.tmux.withBattery
      pkgs.tmuxPlugins.battery;
      extraConfig = # tmux
        ''
          set -a terminal-features 'alacritty:RGB'
          set -g status on
          set -g status-position "top"
          set -g mouse on
          bind c new-window -c "#{pane_current_path}"
          bind '"' split-window -c "#{pane_current_path}"
          bind % split-window -h -c "#{pane_current_path}"
        '';
    };
  };
}

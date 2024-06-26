{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    tmux.enable = lib.mkEnableOption "enables and configures tmux";
  };

  config = lib.mkIf config.rFeatures.tmux.enable {
    programs.tmux = {
      enable = true;
      terminal = "tmux-256color";
      keyMode = "vi";
      disableConfirmationPrompt = true;
      plugins = with pkgs.tmuxPlugins; [ sensible vim-tmux-navigator gruvbox ];
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

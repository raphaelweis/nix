{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    tmux.enable = lib.mkEnableOption "enables and configures tmux";
  };

  config = lib.mkIf config.rFeatures.tmux.enable {
    home.packages = with pkgs; [ acpi ];
    programs.tmux = {
      enable = true;
      terminal = "tmux-256color";
      keyMode = "vi";
      disableConfirmationPrompt = true;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        vim-tmux-navigator
        gruvbox
        {
          plugin = battery;
          extraConfig = # tmux
            ''
              set-option -g status-right "#[bg=colour237,fg=colour239 nobold, nounderscore, noitalics]#[bg=colour239,fg=colour246] #{battery_percentage}  %Y-%m-%d  %H:%M #[bg=colour239,fg=colour248,nobold,noitalics,nounderscore]#[bg=colour248,fg=colour237] #h "
            '';
        }
      ];
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

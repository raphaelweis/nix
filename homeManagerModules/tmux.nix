{ lib, pkgs, ... }:
{
  options.rw = {
    tmux.enable = lib.mkEnableOption "tmux configuration.";
  };
  config = {
    programs.tmux = {
      enable = true;
      keyMode = "vi";
      disableConfirmationPrompt = true;
      clock24 = true;
      terminal = "screen-256color";
      newSession = true;
      plugins = with pkgs.tmuxPlugins; [
        vim-tmux-navigator
        prefix-highlight
      ];
      extraConfig = # tmux
        ''
          set-option -sg escape-time 10
          set-option -g focus-events on
          set-option -a terminal-features 'alacritty:RGB'

          # keybinds
          bind c new-window -c "#{pane_current_path}"
          bind '"' split-window -c "#{pane_current_path}"
          bind % split-window -h -c "#{pane_current_path}"
          bind -T copy-mode-vi v send-keys -X begin-selection
          bind -T copy-mode-vi y send-keys -X copy-selection

          set -g status on
          set -g status-position 'top'
          set -g status-interval 1
          set -g status-left-length 100
          set -g status-right-length 100
          set -g status-style "fg=white,bg=#1c1c24"
          set -g status-justify absolute-centre
          set -g message-style "fg=black,bg=cyan"
          set -g status-left "#[fg=black,bg=brightblue]  #H #[fg=white,bg=black]  #S #{prefix_highlight}"
          set -g status-right "#[fg=black,bg=brightblue]   #(hostname -I | awk '{print $1}') "
          setw -g window-status-separator " "
          setw -g window-status-format "#[fg=black,bg=brightwhite] #I #[fg=white,bg=black] #W "
          setw -g window-status-current-format "#[fg=black,bg=yellow] #I #[fg=white,bg=black] #W "
          set -g @prefix_highlight_output_prefix "#[fg=black]#[bg=yellow]"
          set -g @prefix_highlight_output_suffix ""
        '';
    };
  };
}

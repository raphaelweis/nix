{ pkgs, config, ... }:
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [ tmuxPlugins.sensible tmuxPlugins.vim-tmux-navigator ];
    keyMode = "vi";
    mouse = true;
    terminal = "tmux-256color";
    clock24 = true;
    disableConfirmationPrompt = true;
    extraConfig = ''
            # set 256bit color terminal support
      			set -sa terminal-features ',*256col*:RGB'

        		# status line
            set -g status on
            set -g status-style "bg=#${config.colorScheme.colors.base01} fg=#${config.colorScheme.colors.base0D}"
            set -g status-position "top"

        		# reload tmux configuration with <prefix>r
        		unbind r
        		bind r source ~/.config/tmux/tmux.conf

        		# pane splitting and new windows
            bind  c  new-window      -c "#{pane_current_path}"

        		unbind %
        		bind v split-window -h -c "#{pane_current_path}"

        		unbind '"'
        		bind h split-window -v -c "#{pane_current_path}"

        		# pane resizing and maximizing
        		bind -r H resize-pane -L 3
        		bind -r J resize-pane -D 3
        		bind -r K resize-pane -U 3
          	bind -r L resize-pane -R 3

        		bind -r m resize-pane -Z
            # vi mode keybinds
            bind-key -T copy-mode-vi 'v' send -X begin-selection
            bind-key -T copy-mode-vi 'y' send -X copy-selection

            unbind -T copy-mode-vi MouseDragEnd1Pane
    '';
  };
}

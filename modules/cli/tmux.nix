{ pkgs, ... }:
{
	programs.tmux = {
		enable = true;
		plugins = with pkgs; [ tmuxPlugins.sensible tmuxPlugins.vim-tmux-navigator ];
		disableConfirmationPrompt = true;
		prefix = "space";
		keyMode = "vi";
		mouse = true;
		terminal = "tmux-256color";
		clock24 = true;
		extraConfig = ''
			# set 256bit color terminal support
			set -sa terminal-features ',*256col*:RGB'

			# status line
			set -g status on
			set -g status-position top

			# reload tmux configuration with <prefix>r
			unbind r
			bind r source ~/.config/tmux/tmux.conf

			# pane splitting
			unbind %
			bind v split-window -h

			unbind '"'
			bind h split-window -v

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

			####################################
			# COLORSCHEME: gruvbox dark (medium)
			####################################
			set-option -g status "on"

			# default statusbar color
			set-option -g status-style bg=colour237,fg=colour223 # bg=bg1, fg=fg1

			# default window title colors
			set-window-option -g window-status-style bg=colour214,fg=colour237 # bg=yellow, fg=bg1

			# default window with an activity alert
			set-window-option -g window-status-activity-style bg=colour237,fg=colour248 # bg=bg1, fg=fg3

			# active window title colors
			set-window-option -g window-status-current-style bg=red,fg=colour237 # fg=bg1

			# pane border
			set-option -g pane-active-border-style fg=colour250 #fg2
			set-option -g pane-border-style fg=colour237 #bg1

			# message infos
			set-option -g message-style bg=colour239,fg=colour223 # bg=bg2, fg=fg1

			# writing commands inactive
			set-option -g message-command-style bg=colour239,fg=colour223 # bg=fg3, fg=bg1

			# pane number display
			set-option -g display-panes-active-colour colour250 #fg2
			set-option -g display-panes-colour colour237 #bg1

			# clock
			set-window-option -g clock-mode-colour colour109 #blue

			# bell
			set-window-option -g window-status-bell-style bg=colour167,fg=colour235 # bg=red, fg=bg

			## Theme settings mixed with colors (unfortunately, but there is no cleaner way)
			set-option -g status-justify "left"
			set-option -g status-left-style none
			set-option -g status-left-length "80"
			set-option -g status-right-style none
			set-option -g status-right-length "80"
			set-window-option -g window-status-separator ""

			set-option -g status-left "#[bg=colour241,fg=colour248] #S #[bg=colour237,fg=colour241,nobold,noitalics,nounderscore]"
			set-option -g status-right "#[bg=colour237,fg=colour248,nobold,noitalics,nounderscore]#[bg=colour248,fg=colour237] #h "

			set-window-option -g window-status-current-format "#[bg=colour214,fg=colour237,nobold,noitalics,nounderscore]#[bg=colour214,fg=colour239] #I #[bg=colour214,fg=colour239,bold] #W#{?window_zoomed_flag,*Z,} #[bg=colour237,fg=colour214,nobold,noitalics,nounderscore]"
			set-window-option -g window-status-format "#[bg=colour239,fg=colour237,noitalics]#[bg=colour239,fg=colour223] #I #[bg=colour239,fg=colour223] #W #[bg=colour237,fg=colour239,noitalics]"
		'';
	};
}

{ pkgs, ... }:
{
	programs.tmux = {
		enable = true;
		plugins = with pkgs; [ tmuxPlugins.sensible tmuxPlugins.vim-tmux-navigator ];
		shortcut = "space";
		keyMode = "vi";
		mouse = true;
		terminal = "tmux-256color";
		clock24 = true;
		disableConfirmationPrompt = true;
		extraConfig = ''
			# set 256bit color terminal support
			set -sa terminal-features ',*256col*:RGB'

			# status line
			set -g status off # SET TO ON TO ENABLE STATUS LINE

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
		'';
	};
}

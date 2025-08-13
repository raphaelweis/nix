{ pkgs, lib, ... }:
{
  options.rw = {
    devenv.enable = lib.mkEnableOption "configuration for a command line dev environment. This includes shell config, tmux config, cli tools and development tools, but not editor configuration. No graphical tools should be included here.";
  };
  config = {
    home.packages = with pkgs; [
      xclip
      ripgrep
      fd
      gcc
      nodejs
      rlwrap
    ];
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      enableCompletion = true;
      defaultKeymap = "emacs";
      initContent =
        lib.mkOrder 500 # bash
          ''
            autoload -U colors && colors
            PS1="%{$fg[yellow]%}%~%{$fg[red]%} %{$reset_color%}$%b "

            alias ta="tmux attach"
            alias la="ls -la"
          '';
    };

    programs.git = {
      enable = true;
      userEmail = "raphael.weis.g@gmail.com";
      userName = "Raphaël Weis";
      extraConfig = {
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.tmux = {
      enable = true;
      keyMode = "vi";
      disableConfirmationPrompt = true;
      clock24 = true;
      terminal = "screen-256color";
      newSession = true;
      plugins = with pkgs.tmuxPlugins; [
        vim-tmux-navigator
      ];
      extraConfig = # tmux
        ''
          set-option -sg escape-time 10
          set-option -g focus-events on
          set-option -g status-position top

          # keybinds
          bind c new-window -c "#{pane_current_path}"
          bind '"' split-window -c "#{pane_current_path}"
          bind % split-window -h -c "#{pane_current_path}"

          # style
          set -g status-position top
          set -g status-justify absolute-centre
          set -g status-style 'fg=color7 bg=default'
          set -g status-right ""
          set -g status-right '#(cd #{pane_current_path} && git rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo " $(git rev-parse --abbrev-ref HEAD)")'
          set -g status-left '[#S]'
          set -g status-left-style 'fg=color8'
          set -g status-right-length 0
          set -g status-left-length 100
          setw -g window-status-current-style 'fg=colour6 bg=default bold'
          setw -g window-status-current-format '#I:#W '
          setw -g window-status-style 'fg=color8'
        '';
    };
  };
}

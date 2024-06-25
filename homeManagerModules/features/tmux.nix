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
      plugins = with pkgs.tmuxPlugins; [
        sensible
        vim-tmux-navigator
        gruvbox
      ];
      extraConfig = /*tmux*/ ''
        set -a terminal-features 'alacritty:RGB'
        set -g status on
        set -g status-position "top"
      '';
    };
  };
}

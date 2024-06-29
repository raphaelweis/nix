{ lib, config, vars, ... }: {
  options.rFeatures = {
    zsh.enable = lib.mkEnableOption "enables and configures zsh";
  };

  config = lib.mkIf config.rFeatures.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "fzf" ];
        theme = "robbyrussell";
      };
      initExtra = # sh
        ''
          export CUCUMBER_PUBLISH_QUIET=true
          export PATH=$PATH:${vars.homeDir}/.local/share/gem/ruby/3.3.0/bin

          # Autostart / autoattach to tmux
          if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
            tmux attach &> /dev/null || exec tmux new && exit;
          fi
        '';
    };
  };
}

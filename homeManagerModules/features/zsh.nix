{
  lib,
  config,
  vars,
  pkgs,
  ...
}:
{
  options.rFeatures = {
    zsh.enable = lib.mkEnableOption "enables and configures zsh";
  };

  config = lib.mkIf config.rFeatures.zsh.enable {
    home.packages = with pkgs; [ fd ];
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "fzf"
        ];
        theme = "robbyrussell";
      };
      initExtra = # bash
        ''
          export ANDROID_HOME=${vars.homeDir}/Android/Sdk
          export CUCUMBER_PUBLISH_QUIET=true
          export PATH=$PATH:${vars.homeDir}/Android/Sdk/platform-tools:${vars.homeDir}/Android/Sdk/emulator:$HOME/.local/bin
          export EDITOR=nvim

          bindkey -s "^[s" "tmux-sessionizer\n"
          alias vim='nvim'
          alias ta='tmux attach'
        '';
    };
  };
}

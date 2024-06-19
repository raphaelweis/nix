{ lib, config, inputs, ... }: {
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
        plugins = [ "git" ];
        theme = "robbyrussell";
      };
    };
  };
}

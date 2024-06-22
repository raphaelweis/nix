{ lib, config, ... }: {
  options.rFeatures = {
    fzf.enable = lib.mkEnableOption "enables and configures fzf";
  };

  config = lib.mkIf config.rFeatures.fzf.enable {
    programs.fzf = {
      enable = true;
			enableBashIntegration = true;
			enableZshIntegration = true;
    };
  };
}

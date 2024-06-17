{ lib, config, inputs, ... }: {
  options.rFeatures = {
    git.enable = lib.mkEnableOption "enables and configures git";
  };

  config = lib.mkIf config.rFeatures.git.enable {
    programs.git = {
      enable = true;
      userEmail = "raphael.weis@outlook.com";
      userName = "Raphaël Weis";
    };
  };
}

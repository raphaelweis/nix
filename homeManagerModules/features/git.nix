{ lib, config, ... }:
{
  options.rFeatures = {
    git.enable = lib.mkEnableOption "git the version manager";
  };

  config = lib.mkIf config.rFeatures.git.enable {
    programs.git = {
      enable = true;
      userEmail = "raphael.weis@outlook.com";
      userName = "Raphaël Weis";
      extraConfig.pull.rebase = true;
    };
  };
}

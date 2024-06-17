{ lib, config, inputs, ... }: {
  options.custom = {
    git.enable = lib.mkEnableOption "enables and configures git";
  };

  config = lib.mkIf config.custom.git.enable {
    programs.git = {
      enable = true;
      userEmail = "raphael.weis@outlook.com";
      userName = "Raphaël Weis";
    };
  };
}

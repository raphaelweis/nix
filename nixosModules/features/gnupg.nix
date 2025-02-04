{ lib, config, ... }:
{
  options.rFeatures = {
    gnupg.enable = lib.mkEnableOption "enables and configures gnupg";
  };

  config = lib.mkIf config.rFeatures.gnupg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}

{ lib, config, ... }: {
  options.rFeatures = {
    firefox.enable = lib.mkEnableOption "enables and configures firefox";
  };

  config = lib.mkIf config.rFeatures.firefox.enable {
    programs.firefox = {
      enable = true;
    };
  };
}

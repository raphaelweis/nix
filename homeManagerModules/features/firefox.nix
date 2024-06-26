{ lib, config, ... }: {
  options.rFeatures = {
    firefox.enable = lib.mkEnableOption "enables and configures firefox";
  };

  config = lib.mkIf config.rFeatures.firefox.enable {
    systemd.user.sessionVariables.MOZ_USE_XINPUT2 = "1";

    programs.firefox = { enable = true; };
  };
}

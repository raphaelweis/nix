{
  lib,
  config,
  ...
}:
{
  options.rFeatures = {
    locale.enable = lib.mkEnableOption "Keyboard and locale configuration for the system.";
  };

  config = lib.mkIf config.rFeatures.locale.enable {
    time.timeZone = "Europe/Paris";
    i18n = {
      defaultLocale = "en_US.UTF-8";
      inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 = {
          waylandFrontend = true;
        };
      };
    };
    services.xserver.xkb = {
      layout = "us";
      variant = "intl";
    };
  };
}

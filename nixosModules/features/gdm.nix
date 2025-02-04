{ lib, config, ... }:
{
  options.rFeatures = {
    gdm.enable = lib.mkEnableOption "enables and configures gdm";
  };

  config = lib.mkIf config.rFeatures.gdm.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
        banner = "Got a Benjamin and a Jackson all in my house like i'm Joe, okay";
      };
    };
  };
}

{ lib, config, ... }:
{
  options.rFeatures = {
    hyprpaper.enable = lib.mkEnableOption "enables and configures hyprpaper";
  };

  config = lib.mkIf config.rFeatures.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
    };
  };
}

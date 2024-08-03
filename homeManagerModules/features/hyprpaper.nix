{ lib, config, ... }:
let wallpaper = .../../assets/wallpaper.png;
in {
  options.rFeatures = {
    hyprpaper.enable = lib.mkEnableOption "enables and configures hyprpaper";
  };

  config = lib.mkIf config.rFeatures.hyprpaper.enable {
    services.hyprpaper = {
      enable = false;
      settings = {
        preload = wallpaper;
        wallpaper = ",${wallpaper}";
      };
    };
  };
}

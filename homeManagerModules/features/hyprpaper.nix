{ lib, config, ... }:
let wallpaper = .../../assets/wallpaper.png;
in {
  options.rFeatures = {
    hyprpaper.enable = lib.mkEnableOption "enables and configures fzf";
  };

  config = lib.mkIf config.rFeatures.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = wallpaper;
        wallpaper = ",${wallpaper}";
      };
    };
  };
}

{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    dunst.enable = lib.mkEnableOption "dunst the notification daemon";
  };

  config = lib.mkIf config.rFeatures.dunst.enable {
    services.dunst = {
      enable = true;
      iconTheme = {
        name = "Gruvbox-Plus-Dark";
        package = pkgs.gruvbox-plus-icons;
      };
      settings = {
        global = {
          offset = "15x15";
          origin = "top-right";
          corner_radius = 5;
          transparency = 10;
        };
      };
    };
  };
}

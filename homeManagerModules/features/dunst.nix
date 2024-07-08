{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    dunst.enable = lib.mkEnableOption "dunst the notification daemon";
  };

  config = lib.mkIf config.rFeatures.dunst.enable {
    home.packages = with pkgs; [ libnotify ];
    services.dunst = {
      enable = true;
      iconTheme = {
        name = "Gruvbox-Plus-Dark";
        package = pkgs.gruvbox-plus-icons;
      };
      settings = {
        global = {
          offset = "0x15";
          origin = "top-center";
          corner_radius = 5;
          transparency = 10;
        };
      };
    };
  };
}

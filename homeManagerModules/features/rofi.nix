{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    rofi.enable = lib.mkEnableOption "enables and configures rofi";
  };
  config = lib.mkIf config.rFeatures.rofi.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };
  };
}

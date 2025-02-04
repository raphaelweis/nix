{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.rFeatures = {
    sddm.enable = lib.mkEnableOption "sddm nixos configuration";
  };

  config = lib.mkIf config.rFeatures.sddm.enable {
    environment.systemPackages = with pkgs; [ capitaine-cursors-themed ];
    services = {
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        enableHidpi = true;
        settings.Theme = {
          CursorTheme = "Capitaine Cursors - White";
          CursorSize = 24;
        };
      };
    };
  };
}

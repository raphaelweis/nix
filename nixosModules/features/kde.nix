{ lib, config, ... }: {
  options.rFeatures.kde.enable = lib.mkEnableOption "KDE nixos configuration";

  config = lib.mkIf config.rFeatures.kde.enable {
    services = {
      xserver.enable = true;
      desktopManager.plasma6.enable = true;
    };
  };
}

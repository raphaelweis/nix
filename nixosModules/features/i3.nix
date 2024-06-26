{ lib, config, ... }: {
  options.rFeatures.i3.enable = lib.mkEnableOption "i3 nixos configuration";

  config = lib.mkIf config.rFeatures.i3.enable {
    services.xserver = {
      enable = true;
      windowManager.i3.enable = true;
    };
  };
}

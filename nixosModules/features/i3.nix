{ lib, config, ... }: {
  options.rFeatures = { i3.enable = lib.mkEnableOption "enables i3"; };

  config = lib.mkIf config.rFeatures.i3.enable {
    services = {
      xserver = {
        enable = true;
        windowManager.i3.enable = true;
      };
    };
  };
}

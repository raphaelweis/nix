{ lib, config, ... }: {
  options.rFeatures = {
    graphics.enable = lib.mkEnableOption "common graphics options";
  };

  config = lib.mkIf config.rFeatures.graphics.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}

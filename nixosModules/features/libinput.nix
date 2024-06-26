{ lib, config, ... }: {
  options.rFeatures.libinput.enable = lib.mkEnableOption "libinput configuration";

  config = lib.mkIf config.rFeatures.libinput.enable {
    services.libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        tappingDragLock = false;
      };
    };
  };
}

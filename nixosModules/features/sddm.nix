{ lib, config, ... }: {
  options.rFeatures = {
    sddm.enable = lib.mkEnableOption "sddm nixos configuration";
  };

  config = lib.mkIf config.rFeatures.sddm.enable {
    services = {
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}

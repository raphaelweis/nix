{ lib, config, ... }: {
  options.rFeatures = {
    pipewire.enable =
      lib.mkEnableOption "Pipewire configuration for the system";
  };

  config = lib.mkIf config.rFeatures.pipewire.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}

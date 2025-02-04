{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.rFeatures = {
    pipewire.enable = lib.mkEnableOption "Pipewire configuration for the system";
  };

  config = lib.mkIf config.rFeatures.pipewire.enable {
    environment.systemPackages = with pkgs; [ alsa-utils ];
    hardware.enableAllFirmware = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}

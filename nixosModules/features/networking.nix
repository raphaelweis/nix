{ lib, config, ... }:
{
  options.rFeatures.networking = {
    enable = lib.mkEnableOption "Network configuration for the system";
    hostname = lib.mkOption {
      type = lib.types.str;
      description = "The hostname for the system.";
    };
  };

  config = lib.mkIf config.rFeatures.networking.enable {
    networking = {
      hostName = config.rFeatures.networking.hostname;
      networkmanager = {
        enable = true;
        wifi.backend = "iwd";
      };
    };
  };
}

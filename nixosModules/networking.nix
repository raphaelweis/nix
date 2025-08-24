{ lib, config, ... }:
{
  options.rw.networking = {
    enable = lib.mkEnableOption "Networking configuration.";
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "The hostname of the system.";
    };
  };
  config = {
    networking = {
      hostName = config.rw.networking.hostName;
      networkmanager.enable = true;
    };
  };
}

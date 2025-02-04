{ lib, config, ... }:
{
  options.rFeatures = {
    boot.enable = lib.mkEnableOption "systemdboot as the bootloader";
  };

  config = lib.mkIf config.rFeatures.boot.enable {
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
        efi.canTouchEfiVariables = true;
        timeout = 10;
      };
      supportedFilesystems = [ "ntfs" ];
    };
  };
}

{ lib, config, ... }:
{
  options.rFeatures = {
    boot.enable = lib.mkEnableOption "grub as the bootloader";
  };

  config = lib.mkIf config.rFeatures.boot.enable {
    boot = {
      loader = {
        grub = {
          enable = true;
          device = "nodev";
          useOSProber = true;
          efiSupport = true;
        };
        efi.canTouchEfiVariables = true;
        timeout = 10;
      };
      supportedFilesystems = [ "ntfs" ];
    };
  };
}

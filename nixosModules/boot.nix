{ lib, config, ... }:
{
  options.rw = {
    boot.enable = lib.mkEnableOption "boot and boot loader configuration";
  };
  config = lib.mkIf config.rw.boot.enable {
    boot.loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
  };
}

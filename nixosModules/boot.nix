{ lib, ... }:
{
  options.rw = {
    boot.enable = lib.mkEnableOption "boot and boot loader configuration";
  };
  config = {
    boot.loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
  };
}

{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    bluetooth.enable = lib.mkEnableOption "Enables and configures bluetooth";
  };

  config = lib.mkIf config.rFeatures.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      package = pkgs.bluez;
      powerOnBoot = true;
      settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
    };
  };
}

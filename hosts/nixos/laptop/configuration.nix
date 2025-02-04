{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  hmConfig = ./home.nix;

  rFeatures = {
    networking.hostname = "rLaptop";
    light.enable = true;
    console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  };

  services.xserver.dpi = 180;

  system.stateVersion = "24.05";
}

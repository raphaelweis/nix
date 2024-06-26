{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  hmConfig = ./home.nix;

  rFeatures.networking.hostname = "rLaptop";

  services.xserver.dpi = 180;

  system.stateVersion = "24.05";
}

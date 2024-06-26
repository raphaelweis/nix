{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  hmConfig = ./home.nix;

  rFeatures.networking.hostname = "rLaptop";

  system.stateVersion = "24.05";
}

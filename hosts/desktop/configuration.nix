{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  hmConfig = ./home.nix;

  rFeatures.networking.hostname = "rDesktop";

  system.stateVersion = "24.05";
}

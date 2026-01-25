{ ... }:
{
  imports = [ ./hardware-configuration.nix ];

  rw = {
    networking.hostName = "rVM";
    homeManagerConfig = ./home.nix;
  };

  system.stateVersion = "25.05";
}

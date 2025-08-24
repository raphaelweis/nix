{ lib, ... }:
{
  options.rw = {
    steam.enable = lib.mkEnableOption "Steam, the video game platform.";
  };
  config = {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
  };
}

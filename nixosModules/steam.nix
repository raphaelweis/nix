{ lib, config, ... }:
{
  options.rw = {
    steam.enable = lib.mkEnableOption "Steam, the video game platform.";
  };
  config = lib.mkIf config.rw.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
  };
}

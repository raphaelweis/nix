{ lib, pkgs, ... }:
{
  options.rw = {
    dropbox.enable = lib.mkEnableOption "dropbox daemon configuration.";
  };
  config = {
    home.packages = with pkgs; [
      dropbox
    ];
    systemd.user.services.dropbox = {
      Unit = {
        Description = "Dropbox service";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.dropbox}/bin/dropbox";
        Restart = "on-failure";
      };
    };
  };
}

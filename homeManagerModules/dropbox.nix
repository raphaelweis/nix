{ lib, config, ... }:
{
  options.rw = {
    dropbox.enable = lib.mkEnableOption "dropbox daemon configuration.";
  };
  config = {
    services.dropbox = {
      enable = true;
      path = "${config.home.homeDirectory}/Dropbox";
    };
  };
}

{ lib, config, ... }:
{
  options.rw = {
    firefox.enable = lib.mkEnableOption "Firefox (web browser) configuration.";
  };
  config = lib.mkIf config.rw.firefox.enable {
    programs.firefox = {
      enable = true;
      profiles = {
        default = { };
      };
    };
  };
}

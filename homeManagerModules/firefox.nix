{
  lib,
  config,
  ...
}:
{
  options.rw = {
    firefox.enable = lib.mkEnableOption "Firefox (web browser) configuration.";
  };
  config = lib.mkIf config.rw.firefox.enable {
    programs.firefox = {
      enable = true;
      profiles = {
        personal = {
          id = 0;
          name = "personal";
          isDefault = true;
        };
        work = {
          id = 1;
          name = "work";
        };
      };
    };
  };
}

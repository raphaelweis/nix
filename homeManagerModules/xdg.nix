{ lib, config, ... }:
{
  options.rw = {
    xdg.enable = lib.mkEnableOption "xdg directories configuration";
  };
  config = lib.mkIf config.rw.xdg.enable {
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOT_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
      };
    };
  };
}

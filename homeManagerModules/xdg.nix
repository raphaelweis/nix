{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.rw = {
    xdg.enable = lib.mkEnableOption "xdg directories configuration";
  };
  config = lib.mkIf config.rw.xdg.enable {
    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
        # config = {
        #   common = {
        #     "org.freedesktop.impl.portal.FileChooser" = "gtk";
        #   };
        # };
      };
      userDirs = {
        enable = true;
        createDirectories = true;
        extraConfig = {
          XDG_SCREENSHOT_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
        };
      };
    };
  };
}

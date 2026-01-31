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
        config = {
          common = {
            default = [
              "gnome"
              "gtk"
            ];
            "org.freedesktop.impl.portal.ScreenCast" = "gnome";
            "org.freedesktop.impl.portal.Screenshot" = "gnome";
            "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
            "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
          };
        };
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-gnome
        ];
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

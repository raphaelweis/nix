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
      };
      mimeApps = {
        defaultApplications = {
          "text/html" = [ "firefox.desktop" ];
          "text/xml" = [ "firefox.desktop" ];
          "x-scheme-handler/http" = [ "firefox.desktop" ];
          "x-scheme-handler/https" = [ "firefox.desktop" ];
        };
      };
    };
  };
}

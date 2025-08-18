{ lib, pkgs, ... }:
{
  options.rw = {
    dconf.enable = lib.mkEnableOption "dconf (gnome and gnome extensions) configuration.";
  };
  config = {
    home.packages = with pkgs.gnomeExtensions; [
      no-titlebar-when-maximized
      appindicator
    ];
    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = with pkgs.gnomeExtensions; [
          no-titlebar-when-maximized.extensionUuid
          appindicator.extensionUuid
        ];
      };
      "org/gnome/shell/extensions/unite" = {
        extend-left-box = false;
        notifications-position = "center";
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}

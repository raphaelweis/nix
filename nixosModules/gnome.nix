{ lib, pkgs, ... }:
{
  options.rw = {
    gnome.enable = lib.mkEnableOption "Gnome (Full desktop environment)";
  };
  config = {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      gvfs.enable = true;
      udev.packages = [ pkgs.gnome-settings-daemon ];
      gnome = {
        core-apps.enable = true;
        gnome-online-accounts.enable = true;
        gnome-keyring.enable = true;
      };
    };
  };
}

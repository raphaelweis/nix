{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.rw.hyprland = {
    enable = lib.mkEnableOption "Hyprland (Wayland compositor)";
  };
  config = lib.mkIf config.rw.hyprland.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
    programs.hyprland.enable = true;
  };
}

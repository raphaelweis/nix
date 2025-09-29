{
  lib,
  config,
  ...
}:
{
  options.rw.hyprland = {
    enable = lib.mkEnableOption "Hyprland (Wayland compositor)";
  };
  config = lib.mkIf config.rw.hyprland.enable {
    environment.variables = {
      NIXOS_OZONE_WL = "1";
    };
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
  };
}

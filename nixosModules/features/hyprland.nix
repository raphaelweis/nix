{ lib, config, ... }:
{
  options.rFeatures = {
    hyprland.enable = lib.mkEnableOption "Hyprland, the wayland compositor";
  };

  config = lib.mkIf config.rFeatures.hyprland.enable {
    environment.loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec dbus-launch Hyprland
      fi
    '';
    programs.hyprland.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}

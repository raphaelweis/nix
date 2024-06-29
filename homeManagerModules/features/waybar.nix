{ lib, config, ... }: {
  options.rFeatures = {
    waybar.enable = lib.mkEnableOption "waybar, the wayland status bar";
  };
  config = lib.mkIf config.rFeatures.waybar.enable {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = [{
        modules-left = [ "hyprland/workspaces" "mpris" ];
        modules-center = [ "hyprland/window" ];
        modules-right =
          [ "tray" "pulseaudio" "network" "cpu" "memory" "battery" "clock" ];
        "hyprland/workspaces" = { persistent-workspaces = { "*" = 10; }; };
        clock = {
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>
          '';
          format = "{:%a %d-%m-%Y %H:%M}";
        };
      }];
    };
  };
}

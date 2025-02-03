{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    waybar.enable = lib.mkEnableOption "waybar, the wayland status bar";
  };
  config = lib.mkIf config.rFeatures.waybar.enable {
    home.packages = with pkgs; [ font-awesome ];
    programs.waybar = {
      enable = true;
      settings = [{
        margin = "0 0 0 0";
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right =
          [ "battery" "clock" ];
        battery = {
        format = "BAT: {capacity}%";
        interval = 1;
        };
        clock = {
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>
          '';
          format = "{:%a %d-%m-%Y %H:%M}";
        };
      }];
      style = with config.lib.stylix.colors;
      #css 
        ''
          * {
            font-family: "JetBrainsMono NF";
            font-size: 10;
          }

          button {
            all: initial;
          }

          window#waybar {
            background-color: 
              rgba(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b}, 0.95);
            border: none;
            border-radius: 0px;
          }

          window#waybar > box {
            padding: 4px;
          }

          #workspaces button {
            padding: 0 8px;
          }

          #workspaces button.active {
            color: #${base09};
            font-weight: bold;
          }

          #battery,
          #clock {
            padding: 0 8px;
          }

          #battery.discharging {
            color: rgb(${base07-rgb-r}, ${base07-rgb-g}, ${base07-rgb-b});
          }
          #battery.charging {
            color: rgb(${base0C-rgb-r}, ${base0C-rgb-g}, ${base0C-rgb-b});
          }
        '';
    };
  };
}

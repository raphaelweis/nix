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
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "WEB";
            "2" = "COD";
            "3" = "W03";
            "4" = "DIS";
            "5" = "SPO";
            "6" = "THU";
            "7" = "W07";
            "8" = "W08";
            "9" = "W09";
            "10" = "W10";
          };
          persistent-workspaces = { "*" = 5; };
        };
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
            font-family: "JetBrainsMonoNL NF";
          }

          window#waybar {
            background-color: 
              rgba(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b}, 0.90);
            border: none;
            border-radius: 0px;
            margin: 0;
            padding: 0;
          }

          #workspaces button.active {
            color: #${base09};
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

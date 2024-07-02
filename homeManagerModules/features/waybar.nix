{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    waybar.enable = lib.mkEnableOption "waybar, the wayland status bar";
  };
  config = lib.mkIf config.rFeatures.waybar.enable {
    home.packages = with pkgs; [ font-awesome ];
    programs.waybar = {
      enable = true;
      settings = [{
        margin = "5 5 0 5";
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
            "6" = "W06";
            "7" = "W07";
            "8" = "W08";
            "9" = "W09";
            "10" = "W10";
          };
          persistent-workspaces = { "*" = 5; };
        };
        battery.format = "BAT: {capacity}%";
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
            border: 2px solid 
              rgb(${base0D-rgb-r}, ${base0D-rgb-g}, ${base0D-rgb-b});
            border-radius: 5px;
          }

          #workspaces button.active {
            color: #${base09};
          }

          #tray
          #pulseaudio,
          #network,
          #cpu,
          #memory,
          #disk,
          #battery,
          #clock {
            padding: 0 8px;
          }
        '';
    };
  };
}

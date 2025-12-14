{
  lib,
  config,
  theme,
  ...
}:
{
  options.rw = {
    waybar.enable = lib.mkEnableOption "waybar (wayland status bar) configuration.";
  };

  config = lib.mkIf config.rw.waybar.enable {
    programs.waybar = {
      enable = true;

      systemd = {
        enable = true;
      };

      settings = {
        mainBar = {
          layer = "top";
          position = "top";

          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ "clock" ];
          modules-right = [
            "tray"
            "battery"
          ];

          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
          };

          clock = {
            format = "{:%b %e %H:%M}";
          };

          tray = {
            spacing = 8;
          };

          battery = {
            format = "{capacity}%";
          };
        };
      };

      style = # css
        ''
          * {
            font-size: 12px;
            box-shadow: none;
            text-shadow: none;
            background: none;
            transition: none;
            border: none;
            margin: 0;
            padding: 0;
          }

          window#waybar {
            background-color: ${theme.schemes.light.surface};
            color: ${theme.schemes.light.onSurface};
            padding: 6px 12px;

            border-bottom-left-radius: 16px;
            border-bottom-right-radius: 16px;
          }

          #workspaces {
            padding: 4px;
          }

          #workspaces button {
            padding: 0 8px;
            border-radius: 12px;
          }

          #workspaces button.active {
            background-color: ${theme.schemes.light.primary}; /* primary */
            color: ${theme.schemes.light.onPrimary};
          }

          #workspaces button.active:hover {
            background-color: rgba(59, 105, 58, 0.92);
          }

          #clock,
          #battery,
          #tray {
            padding: 0 10px;
          }
        '';
    };
  };
}

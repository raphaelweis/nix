{
  lib,
  config,
  ...
}:
{
  options.rw = {
    waybar.enable = lib.mkEnableOption "waybar (wayland status bar) configuration.";
  };

  config = lib.mkIf config.rw.waybar.enable {
    programs.waybar =
      let
        c = config.lib.stylix.colors;
      in
      {
        enable = true;

        systemd = {
          enable = true;
        };

        settings = {
          mainBar = {
            layer = "top";
            position = "top";

            modules-left = [
              "hyprland/workspaces"
            ];

            modules-center = [
              "clock"
            ];

            modules-right = [
              "cpu"
              "memory"
              "temperature"
              "network"
              "tray"
              "battery"
            ];

            "hyprland/workspaces" = {
              disable-scroll = true;
              all-outputs = true;
            };

            clock = {
              format = "{:%b %e   %H:%M}";
              calendar = {
                mode = "year";
                mode-mon-col = 3;
                format = {
                  today = "<span color='${c.withHashtag.base0B}'><b><u>{}</u></b></span>";
                };
              };
              tooltip = true;
              tooltip-format = ''
                <span color='${c.withHashtag.base05}' font='${config.stylix.fonts.monospace.name}'>{calendar}</span>
              '';
            };

            cpu = {
              format = "   {usage}%";
              tooltip = true;
            };

            memory = {
              format = "    {percentage}%";
              tooltip = true;
            };

            temperature = {
              format = "󰔏  {temperatureC}°C";
              critical-threshold = 80;
              tooltip = true;
            };

            network = {
              format-wifi = "󰖩   {bandwidthDownBits}";
              format-ethernet = "󰈀  {bandwidthDownBits}";
              format-disconnected = "󰖪 ";
              tooltip = true;
              interval = 1;
            };

            tray = {
              spacing = 8;
            };

            battery = {
              format = "{icon} {capacity}%";
              format-discharging = "{icon} {capacity}%";
              format-charging = "{icon} {capacity}%";
              format-plugged = "{icon} {capacity}%";
              format-full = "{icon} {capacity}%";
              format-icons = {
                discharging = [
                  "󰂎 "
                  "󰁺 "
                  "󰁻 "
                  "󰁼 "
                  "󰁽 "
                  "󰁾 "
                  "󰁿 "
                  "󰂀 "
                  "󰂁 "
                  "󰂂 "
                  "󰁹 "
                ];
                plugged = [
                  "󰢟 "
                  "󰢜 "
                  "󰂆 "
                  "󰂇 "
                  "󰂈 "
                  "󰢝 "
                  "󰂉 "
                  "󰢞 "
                  "󰂊 "
                  "󰂋 "
                  "󰂅 "
                ];
                full = [
                  "󰁹 "
                ];
              };
            };
          };
        };

        style =
          # css
          ''
            * {
              box-shadow: none;
              text-shadow: none;
              background: none;
              transition: none;
              border: none;
              margin: 0;
              padding: 0;

              font-size: 12px;
              font-weight: bold;
            }

            window#waybar {
              background-color: ${c.withHashtag.base07};
              color: ${c.withHashtag.base06};
              padding: 6px 12px;
            }

            #workspaces {
              padding: 4px;
            }

            #workspaces button {
              color: ${c.withHashtag.base06};
              padding: 0 8px;
              border-radius: 8px;
            }

            #workspaces button.active {
              background-color: ${c.withHashtag.base0D};
              color: ${c.withHashtag.base02};
            }

            #clock {
              font-size: 14px;
            }

            #cpu,
            #memory,
            #temperature,
            #network {
              font-size: 13px;
              padding: 0 10px;
            }

            #temperature.critical {
              color: ${c.withHashtag.base08};
            }

            #tray {
              padding: 0 16px;
            }

            #battery {
              padding: 0 8px;
            }

            tooltip {
              background-color: rgba(${c.base00-rgb-r}, ${c.base00-rgb-g}, ${c.base00-rgb-b}, 0.95);
              border-radius: 12px;
              padding: 8px;
            }
          '';
      };
  };
}

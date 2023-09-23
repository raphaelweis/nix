{ vars, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      bar = {
        position = "left";
        layer = "top";
        width = 55;
        spacing = 7;

        modules-left = [ "image#nixos-logo" "tray" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "clock" "custom/power" ];

        "image#nixos-logo" = {
          path = ../../../assets/images/nixos-logo.png;
          size = 32;
        };
        "tray" = {
          icon-size = 21;
          spacing = 10;
          show-passive-items = true;
        };
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          active-only = false;
          format-icons = {
            default = "";
          };
          persistent_workspaces = {
            "*" = 10;
          };
        };
        "clock" = {
          interval = 60;
          format = "{:%H\n%M}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>
          '';
        };
        "custom/power" = {
          tooltip = false;
          on-click =
            let
              rofi = vars.programs.rofi.package + "/bin/rofi";
              poweroff = pkgs.systemd + "/bin/poweroff";
              reboot = pkgs.systemd + "/bin/reboot";
            in
            pkgs.writeShellScript "shutdown-waybar" ''

              #!/bin/sh

              off=" Shutdown"
              reboot=" Reboot"
              cancel="󰅖 Cancel"

              sure="$(printf '%s\n%s\n%s' "$off" "$reboot" "$cancel" |
          	  ${rofi} -dmenu -p ' Are you sure?')"

              if [ "$sure" = "$off" ]; then
          	    ${poweroff}
              elif [ "$sure" = "$reboot" ]; then
          	    ${reboot}
              fi
          '';
          format = "󰐥";
        };
      };
    };
  };
}

{ vars, ... }:
let
  systemdTarget = if vars.display.vm == "Hyprland" then "hyprland-session.target" else "graphical-session.target";
  # swaylock = "${pkgs.swaylock}/bin/swaylock";
  # timeout = 10 * 60;
in
{
  services.swayidle = {
    enable = true;
    systemdTarget = "${systemdTarget}";
    timeouts = [ ];
  };
}

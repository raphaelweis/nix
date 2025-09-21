{ lib, config, ... }:
{
  options.rw = {
    i3status.enable = lib.mkEnableOption "i3status configuration.";
  };
  config = lib.mkIf config.rw.i3status.enable {
    programs.i3status = {
      enable = true;
      general = {
        colors = true;
        color_good = "#7fa563";
        color_degraded = "#f3be7c";
        color_bad = "#d8647e";
        interval = 1;
      };
      modules = {
        "wireless _first_" = {
          enable = true;
          position = 1;
          settings = {
            format_up = "W: (%quality at %essid)";
          };
        };
        "ethernet _first_" = {
          enable = true;
          position = 2;
        };
        "battery all" = {
          enable = true;
          position = 3;
          settings = {
            format = "%status %percentage";
            last_full_capacity = true;
            format_percentage = "%.00f%s";
            low_threshold = "20";
            threshold_type = "percentage";
          };
        };
        "tztime local" = {
          enable = true;
          position = 4;
          settings = {
            format = "%d/%m/%Y %H:%M";
          };
        };
        "ipv6" = {
          enable = false;
        };
        "load" = {
          enable = false;
        };
        "disk /" = {
          enable = false;
        };
        "memory" = {
          enable = false;
        };
      };
    };
  };
}

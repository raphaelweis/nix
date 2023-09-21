{ ... }:
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
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ ];
        modules-right = [ ];
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          active-only = false;
          format-icons = {
            active = "";
            default = "";
          };
          persistent_workspaces = {
            "*" = 9;
          };
        };
      };
    };
  };
}

{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    hyprland.enable = lib.mkEnableOption "enables and configures hyprland";
  };
  config = lib.mkIf config.rFeatures.hyprland.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
      configPackages = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
    };
    home.packages = with pkgs; [ xwaylandvideobridge ];
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        dwindle.force_split = 2;
        input = {
          kb_layout = "us";
          kb_variant = "intl";
          touchpad = {
            natural_scroll = true;
          };
        };
        exec-once = [
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        ];
        bind = [
          "$mod, C, killactive"
          "CTRL ALT SHIFT, L, exit"
          "$mod, H, movefocus, l"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"
          "$mod SHIFT, H, swapwindow, l"
          "$mod SHIFT, J, swapwindow, d"
          "$mod SHIFT, K, swapwindow, u"
          "$mod SHIFT, L, swapwindow, r"

          "$mod, P, exec, rofi -show run"
          "$mod, Q, exec, firefox"
          "$mod, RETURN, exec, alacritty"
          "$mod, E, exec, nautilus"
        ] ++ (builtins.concatLists (builtins.genList (x:
          let
            ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
          in [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]) 10));
        bindr = [ "SUPER, SUPER_L, exec, rofi -show drun || pkill rofi" ];
        windowrulev2 = [
          "opacity 0.0 override,class:^(xwaylandvideobridge)$"
          "noanim,class:^(xwaylandvideobridge)$"
          "noinitialfocus,class:^(xwaylandvideobridge)$"
          "maxsize 1 1,class:^(xwaylandvideobridge)$"
          "noblur,class:^(xwaylandvideobridge)$"
        ];
      };
    };
  };
}

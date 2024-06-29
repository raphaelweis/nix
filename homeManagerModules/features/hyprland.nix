{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    hyprland = {
      enable = lib.mkEnableOption "enables and configures hyprland";
      gdkScale = lib.mkOption {
        type = lib.types.int;
        default = 1;
        description =
          "sets the GDK_SCALE environnement variable for xwayland apps. Useful for HiDPI screens.";
      };
    };
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
    home.packages = with pkgs; [ xwaylandvideobridge playerctl ];
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        general = {
          border_size = 2;
          gaps_in = 2.5;
          gaps_out = 5;
        };
        decoration.rounding = 5;
        input = {
          kb_layout = "us";
          kb_variant = "intl";
          touchpad.natural_scroll = true;
        };
        animation = [
          "workspaces, 1, 1, default, slide"
          "windows, 1, 3, default, slide"
        ];
        dwindle.force_split = 2;
        xwayland.force_zero_scaling = true;
        misc.disable_hyprland_logo = true;
        env = [ "GDK_SCALE,${toString config.rFeatures.hyprland.gdkScale}" ];
        exec-once = [
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "hyprpaper"
          "hyprctl setcursor 'Capitaine Cursors - White' 24"
          "sleep 5; keepassxc"
          "[workspace 4 silent] discord --start-minimized"
          "[workspace 5 silent] spotify"
        ];
        bind = [
          "$mod, C, killactive"
          "$mod, M, fullscreen"
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
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
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
          "workspace 4 silent,class:^(discord)$"
          "workspace 5 silent,class:^(spotify)$"
        ];
      };
    };
  };
}

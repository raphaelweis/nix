{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.rw.hyprland = {
    enable = lib.mkEnableOption "Hyprland configuration.";
  };
  config = lib.mkIf config.rw.hyprland.enable {
    home = {
      packages = with pkgs; [
        grimblast
        playerctl
        gnome-themes-extra
        adwaita-icon-theme
      ];
    };
    wayland.windowManager.hyprland = {
      enable = true;
      # Disable systemd integration if using uwsm.
      systemd.enable = false;
      settings = {
        monitor = [
          "eDP-1, 2944x1840@90, 0x0, 1.92"
        ];
        input = {
          kb_layout = "us";
          kb_variant = "intl";
          accel_profile = "flat";
          touchpad = {
            natural_scroll = true;
          };
        };

        dwindle = {
          preserve_split = true;
          force_split = 2;
        };

        "$mod" = "SUPER";
        bind = [
          # Window / Hyprland management
          "$mod, w, killactive"
          "$mod, h, movefocus, l"
          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"
          "$mod, l, movefocus, r"
          "$mod SHIFT, h, movewindoworgroup, l"
          "$mod SHIFT, j, movewindoworgroup, d"
          "$mod SHIFT, k, movewindoworgroup, u"
          "$mod SHIFT, l, movewindoworgroup, r"
          "$mod, F, togglefloating"
          "$mod, M, fullscreen"
          "bind = SUPER, T, layoutmsg, togglesplit"

          # Workspaces
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"

          # Launch apps / programs
          "ALT, space, exec, rofi -show drun"
          "$mod, return, exec, ghostty"
          "$mod, Q, exec, zen"
          "$mod, E, exec, nautilus"
          "$mod SHIFT, S, exec, NOW=$(date +%d-%b-%Y_%H-%M-%S) && grimblast --notify --freeze copysave area ${config.xdg.userDirs.extraConfig.XDG_SCREENSHOT_DIR}/screenshot_$NOW.png"

          # Special keys / Other keybinds
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
          "$mod, F9, exec, bluetoothctl connect 88:C9:E8:AD:13:39"

        ];
      };
    };
    services.hyprpaper =
      let
        wallpaper = ../resources/assets/windows.jpg;
      in
      {
        enable = true;
        settings = {
          preload = [ "${wallpaper}" ];
          wallpaper = [ ", ${wallpaper}" ];
        };
      };
  };
}

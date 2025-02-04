{
  lib,
  config,
  pkgs,
  vars,
  ...
}:
{
  options.rFeatures = {
    hyprland = {
      enable = lib.mkEnableOption "enables and configures hyprland";
      gdkScale = lib.mkOption {
        type = lib.types.int;
        default = 1;
        description = "sets the GDK_SCALE environment variable for xwayland apps. Useful for HiDPI screens.";
      };
      isOnNixos = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether the host is NixOS or not. Used to determine the use of tools like nixGL.";
      };
    };
  };
  config = lib.mkIf config.rFeatures.hyprland.enable {
    home.packages = with pkgs; [
      playerctl
      grim
      slurp
      wl-clipboard
      grimblast
      jq
      libnotify
      hyprpicker
    ];
    programs.kitty.enable = true; # if there is a problem with hyprland config, at least we'll have that installed.
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.variables = [ "--all" ];
      settings = {
        "$mod" = "SUPER";
        dwindle = {
          force_split = 2;
        };
        general = {
          border_size = 1;
          gaps_in = 0;
          gaps_out = 0;
        };
        decoration = {
          shadow = {
            enabled = false;
          };
          dim_inactive = false;
          dim_strength = 0.25;
        };
        input = {
          touchpad = {
            natural_scroll = true;
            scroll_factor = 0.4;
          };
          kb_layout = "us";
          kb_variant = "intl";
        };
        device = {
          name = "logitech-g502-1";
          sensitivity = -0.5;
        };
        misc = {
          disable_hyprland_logo = true;
        };
        xwayland = {
          force_zero_scaling = true;
        };
        env = [
          "GDK_SCALE, ${toString config.rFeatures.hyprland.gdkScale}"
        ];
        exec-once = [
          "systemctl --user start hyprpaper.service"
        ];
        animation = [
          "workspaces, 1, 0.5, default, slide"
          "windows, 1, 1, default, popin"
        ];
        bind =
          [
            "$mod, C, killactive"
            "$mod, M, fullscreen"
            "CTRL ALT SHIFT, L, exit"
            "$mod, H, movefocus, l"
            "$mod, J, movefocus, d"
            "$mod, K, movefocus, u"
            "$mod, L, movefocus, r"
            "$mod SHIFT, H, movewindoworgroup, l"
            "$mod SHIFT, J, movewindoworgroup, d"
            "$mod SHIFT, K, movewindoworgroup, u"
            "$mod SHIFT, L, movewindoworgroup, r"
            "$mod, T, togglegroup"
            "$mod, F, togglefloating"
            "ALT, TAB, changegroupactive, f"
            "$mod, P, exec, rofi -show run"
            "ALT, SPACE, exec, rofi -show calc -modi calc -no-show-match -no-sort -calc-command 'echo -n '{result}' | wl-copy'"
            "$mod, Q, exec, zen"
            "$mod, RETURN, exec, alacritty      "
            "$mod, E, exec, nautilus"
            "$mod, F9, exec, bluetoothctl connect 88:C9:E8:AD:13:39"
            "$mod SHIFT, S, exec, NOW=$(date +%d-%b-%Y_%H-%M-%S) && grimblast --notify --freeze copysave area ${vars.screenshotsDir}/screenshot_$NOW.png"
            ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            ", XF86AudioPlay, exec, playerctl play-pause"
            ", XF86AudioNext, exec, playerctl next"
            ", XF86AudioPrev, exec, playerctl previous"
          ]
          ++ (builtins.concatLists (
            builtins.genList (
              i:
              let
                ws = i + 1;
              in
              [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            ) 9
          ));
        bindr = [
          "SUPER, SUPER_L, exec, rofi -show drun -show-icons || pkill rofi"
        ];
        windowrulev2 = [
          "rounding 5 ,floating:1"
          "bordersize 2,floating:1"
          "workspace 4 silent,class:^(discord)$"
          "workspace 5 silent,class:^(Spotify)$"
          "workspace 6 silent,class:^(thunderbird)$"
          "noborder, onworkspace:w[t1]"
        ];
      };
    };
  };
}

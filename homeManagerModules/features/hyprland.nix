{ lib, config, pkgs, vars, ... }: {
  options.rFeatures = {
    hyprland = {
      enable = lib.mkEnableOption "enables and configures hyprland";
      gdkScale = lib.mkOption {
        type = lib.types.int;
        default = 1;
        description =
          "sets the GDK_SCALE environnement variable for xwayland apps. Useful for HiDPI screens.";
      };
      isOnNixos = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description =
          "Whether the host is NixOS or not. Used to determine the use of tools like nixGL.";
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
    home.file."${config.xdg.configHome}/hypr/hyprland.conf".text = let
      c = config.lib.stylix.colors;
      #hyprlang 
    in  ''
      $mod=SUPER

      dwindle {
        force_split=2
      }

      general {
        border_size=1
        gaps_in=0
        gaps_out=0
        col.active_border=rgb(${c.base0C})
      }

      decoration {
        shadow {
          enabled=false
        }
        dim_inactive = false
        dim_strength = 0.25
      }

      input {
        touchpad {
          natural_scroll=true
        }
        kb_layout=us
        kb_variant=intl
      }

      misc {
        disable_hyprland_logo=true
      }

      xwayland {
        force_zero_scaling=true
      }

      env=GDK_SCALE, ${toString config.rFeatures.hyprland.gdkScale}

      exec-once = systemctl --user start hyprpaper.service

      animation=workspaces, 1, 0.5, default, slide
      animation=windows, 1, 1, default, popin

      bind=$mod, C, killactive
      bind=$mod, M, fullscreen
      bind=CTRL ALT SHIFT, L, exit
      bind=$mod, H, movefocus, l
      bind=$mod, J, movefocus, d
      bind=$mod, K, movefocus, u
      bind=$mod, L, movefocus, r
      bind=$mod SHIFT, H, movewindoworgroup, l
      bind=$mod SHIFT, J, movewindoworgroup, d
      bind=$mod SHIFT, K, movewindoworgroup, u
      bind=$mod SHIFT, L, movewindoworgroup, r
      bind=$mod, T, togglegroup
      bind=$mod, F, togglefloating
      bind=ALT, TAB, changegroupactive, f
      bind=$mod, P, exec, rofi -show run
      bind=ALT, SPACE, exec, rofi -show calc -modi calc -no-show-match -no-sort -calc-command "echo -n '{result}' | wl-copy"
      bind=$mod, Q, exec, zen
      bind=$mod, RETURN, exec, alacritty      
      bind=$mod, E, exec, nautilus
      bind=$mod, F9, exec, bluetoothctl connect 88:C9:E8:AD:13:39
      bind=$mod SHIFT, S, exec, NOW=$(date +%d-%b-%Y_%H-%M-%S) && grimblast --notify --freeze copysave area ${vars.screenshotsDir}/screenshot_$NOW.png
      bind=, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
      bind=, XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-
      bind=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind=, XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bind=, XF86AudioPlay, exec, playerctl play-pause
      bind=, XF86AudioNext, exec, playerctl next
      bind=, XF86AudioPrev, exec, playerctl previous
      bind=$mod, 1, workspace, 1
      bind=$mod SHIFT, 1, movetoworkspace, 1
      bind=$mod, 2, workspace, 2
      bind=$mod SHIFT, 2, movetoworkspace, 2
      bind=$mod, 3, workspace, 3
      bind=$mod SHIFT, 3, movetoworkspace, 3
      bind=$mod, 4, workspace, 4
      bind=$mod SHIFT, 4, movetoworkspace, 4
      bind=$mod, 5, workspace, 5
      bind=$mod SHIFT, 5, movetoworkspace, 5
      bind=$mod, 6, workspace, 6
      bind=$mod SHIFT, 6, movetoworkspace, 6
      bind=$mod, 7, workspace, 7
      bind=$mod SHIFT, 7, movetoworkspace, 7
      bind=$mod, 8, workspace, 8
      bind=$mod SHIFT, 8, movetoworkspace, 8
      bind=$mod, 9, workspace, 9
      bind=$mod SHIFT, 9, movetoworkspace, 9
      bind=$mod, 0, workspace, 10
      bind=$mod SHIFT, 0, movetoworkspace, 10
      bindm=$mod, mouse:272, movewindow
      bindm=$mod, mouse:273, resizewindow
      bindr=SUPER, SUPER_L, exec, rofi -show drun -show-icons || pkill rofi

      windowrulev2=rounding 5 ,floating:1
      windowrulev2=bordersize 2,floating:1
      windowrulev2=workspace 4 silent,class:^(discord)$
      windowrulev2=workspace 5 silent,class:^(Spotify)$
      windowrulev2=workspace 6 silent,class:^(thunderbird)$
      windowrulev2 = noborder, onworkspace:w[t1]
    '';
  };
}

{ pkgs, vars, inputs, ... }:
{
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  home = {
    packages = with pkgs;
      [
        pw-volume
        playerctl
        dbus
        dconf
        grim
        slurp
        wl-clipboard
        wlr-randr
        rofi-wayland
        xwayland
        qt6.qtwayland
        libsForQt5.qt5.qtwayland
        xdg-utils
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    sessionVariables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
      GDK_BACKEND = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      MOZ_ENABLE_WAYLAND = "1";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    extraConfig = ''
      monitor = ${vars.display.monitor1}, ${vars.display.resolution}@${toString vars.display.refresh-rate}, auto, ${vars.display.scale}

      env = XCURSOR_SIZE, ${toString vars.theme.cursor.size}

      exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
      exec-once = hyprctl setcursor ${vars.theme.cursor.theme} ${toString vars.theme.cursor.size}
      exec-once = hyprpaper &

      input {
        follow_mouse = 1
        kb_layout = us
        kb_variant = intl
        sensitivity = 0
        touchpad {
          natural_scroll = true
        }
      }

      general {
        border_size = 2
        col.active_border = rgb(fabd2f) rgb(d79921) 45deg
        col.inactive_border = rgba(00000000)
        gaps_in = 5
        gaps_out = 10
        layout = dwindle
      }

      decoration {
        blur {
          enabled = true
          passes = 3
          size = 2
        }
        col.shadow = rgba(1a1a1aee)
        drop_shadow = true
        rounding = 5
        shadow_range = 4
        shadow_render_power = 3
      }

      animations {
        bezier = myBezier, 0.05, 0.9, 0.1, 1.05
        animation = windows, 1, 7, default
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 3, default
        enabled = yes
      }

      dwindle {
        preserve_split = true
        pseudotile = true
      }

      master {
        new_is_master = true
      }

      windowrule = float, pavucontrol

      bind = SUPER, Q, exec, ${vars.programs.chrome.command}
      bind = SUPER, RETURN, exec, ${vars.programs.alacritty.command}
      bind = SUPER, C, killactive,
      bind = SUPER SHIFT, M, exit,
      bind = SUPER, E, exec, ${vars.programs.nautilus.command}
      bind = SUPER, V, togglefloating,
      bind = SUPER, M, fullscreen,
      bind = SUPER, P, exec, ${vars.programs.rofi.package}/bin/rofi -show run
      bindr = SUPER, SUPER_L, exec, ${vars.programs.rofi.package}/bin/rofi -show run || pkill ${vars.programs.rofi.name}
      bind = SUPER, J, togglesplit, dwindle
      bind = SUPER SHIFT, L, exec, ${vars.programs.swaylock.command}

      binde = , XF86AudioRaiseVolume, exec, pw-volume change +5%
      binde = , XF86AudioLowerVolume, exec, pw-volume change -5%
      bind = , XF86MonBrightnessUp, exec, light -A 10
      bind = , XF86MonBrightnessDown, exec, light -U 10
      bind = , XF86AudioMute, exec, pw-volume mute toggle
      bind = , XF86AudioPlay, exec, playerctl play-pause
      bind = , XF86AudioPrev, exec, playerctl previous
      bind = , XF86AudioNext, exec, playerctl next

      bind = SUPER, left, movefocus, l
      bind = SUPER, right, movefocus, r
      bind = SUPER, up, movefocus, u
      bind = SUPER, down, movefocus, d

      bind = SUPER, 1, workspace, 1
      bind = SUPER, 2, workspace, 2
      bind = SUPER, 3, workspace, 3
      bind = SUPER, 4, workspace, 4
      bind = SUPER, 5, workspace, 5
      bind = SUPER, 6, workspace, 6
      bind = SUPER, 7, workspace, 7
      bind = SUPER, 8, workspace, 8
      bind = SUPER, 9, workspace, 9
      bind = SUPER, 0, workspace, 10

      bind = SUPER SHIFT, 1, movetoworkspace, 1
      bind = SUPER SHIFT, 2, movetoworkspace, 2
      bind = SUPER SHIFT, 3, movetoworkspace, 3
      bind = SUPER SHIFT, 4, movetoworkspace, 4
      bind = SUPER SHIFT, 5, movetoworkspace, 5
      bind = SUPER SHIFT, 6, movetoworkspace, 6
      bind = SUPER SHIFT, 7, movetoworkspace, 7
      bind = SUPER SHIFT, 8, movetoworkspace, 8
      bind = SUPER SHIFT, 9, movetoworkspace, 9
      bind = SUPER SHIFT, 0, movetoworkspace, 10

      bind = SUPER, mouse_down, workspace, e+1
      bind = SUPER, mouse_up, workspace, e-1
      bindm = SUPER, mouse:272, movewindow
      bindm = SUPER, mouse:273, resizewindow
    '';
  };
}

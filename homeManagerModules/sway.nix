{ pkgs, lib, ... }:
{
  options.rw = {
    sway.enable = lib.mkEnableOption "sway configuration.";
  };
  config = {
    home.packages = with pkgs; [
      wl-clipboard
      playerctl
      brightnessctl
      hyprpicker
    ];
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      config = rec {
        modifier = "Mod4";
        terminal = "ghostty";
        gaps.smartBorders = "on";
        defaultWorkspace = "workspace number 1";
        window = {
          border = 1;
          titlebar = false;
        };
        output = {
          eDP-1 = {
            mode = "2944x1840@60Hz";
            scale = "2";
            bg = "${../assets/the_solo_traveller_wallpaper_laptop.png} fill";
          };
        };
        input = {
          "type:keyboard" = {
            xkb_layout = "us(intl)";
          };
          "type:touchpad" = {
            dwt = "enabled";
            tap = "enabled";
            drag_lock = "disabled";
            natural_scroll = "enabled";
            scroll_factor = "0.5";
          };
          "type:pointer" = {
            accel_profile = "flat";
            pointer_accel = "0.5";
          };
        };
        startup = [
          {
            command = "ghostty --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false";
          }
        ];
        keybindings =
          let
            browser = "zen";
            run = "tofi-run | xargs swaymsg exec --";
            drun = "tofi-drun | xargs swaymsg exec --";
          in
          lib.mkOptionDefault {
            # Window and app controls
            "${modifier}+q" = "exec ${browser}";
            "${modifier}+c" = "kill";
            "${modifier}+Return" = "exec ${terminal}";
            "ALT+TAB" = "workspace back_and_forth";
            "ALT+SPACE" = "exec ${run}";
            "--release Super_L" = "exec ${drun}";
            "${modifier}+Shift+c" = "exec hyprpicker -a";

            # XF86 controls
            "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
            "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
            "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
            "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
            "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";
            "XF86MonBrightnessUp" = "exec brightnessctl set 10%+";
            "XF86AudioPlay" = "exec playerctl play-pause";
            "XF86AudioNext" = "exec playerctl next";
            "XF86AudioPrev" = "exec playerctl previous";
          };
      };
    };
  };
}

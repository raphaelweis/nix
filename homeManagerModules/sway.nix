{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.rw = {
    sway.enable = lib.mkEnableOption "sway configuration.";
  };
  config = lib.mkIf config.rw.sway.enable {
    home.packages = with pkgs; [
      wl-clipboard
      playerctl
      brightnessctl
      hyprpicker
      sway-contrib.grimshot
    ];
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      config = rec {
        modifier = "Mod4";
        terminal = "alacritty";
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
            bg = "${../resources/assets/the_solo_traveller_wallpaper_laptop.png} fill";
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
        # startup = [
        #   {
        #     # command = "ghostty --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false";
        #   }
        # ];
        keybindings =
          let
            browser = "zen";
            run = "rofi -show run";
            drun = "pkill rofi || rofi -show drun";
            file_manager = "nautilus --new-window";
          in
          lib.mkOptionDefault {
            # Window and app controls
            "${modifier}+q" = "exec ${browser}";
            "${modifier}+c" = "kill";
            "${modifier}+Return" = "exec ${terminal}";
            "${modifier}+e" = "exec ${file_manager}";
            "${modifier}+Shift+e" = "layout toggle split";
            "ALT+TAB" = "workspace back_and_forth";
            "ALT+SPACE" = "exec ${run}";
            "--release Super_L" = "exec ${drun}";
            "${modifier}+Shift+c" = "exec hyprpicker -al";
            "${modifier}+Shift+s" =
              "exec NOW=$(date +%d-%b-%Y_%H-%M-%S) && grimshot --notify savecopy area $HOME/Pictures/Screenshots/screenshot_$NOW.png";

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
        bars = [
          {
            command = "${pkgs.sway}/bin/swaybar";
            statusCommand = "${pkgs.i3status}/bin/i3status";
            fonts = {
              names = [ "monospace" ];
              style = "Regular";
              size = "8";
            };
            colors =
              let
                bg = "#1c1c24";
                black = "#252530";
                orange = "#f3be7c";
                white = "#cdcdcd";
              in
              {
                background = bg;
                focusedStatusline = white;
                focusedWorkspace = {
                  text = black;
                  background = orange;
                  border = orange;
                };
                inactiveWorkspace = {
                  text = white;
                  background = bg;
                  border = bg;
                };
              };
          }
        ];
      };
    };
  };
}

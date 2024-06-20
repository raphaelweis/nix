{ lib, pkgs, config, inputs, ... }:
let mod = "Mod4";
in {
  options.rFeatures = {
    i3.enable = lib.mkEnableOption "enables and configures i3";
  };

  config = lib.mkIf config.rFeatures.i3.enable {
    home = {
			packages = with pkgs; [ wmctrl dmenu ];
			file.".background-image".source = ../../assets/wallpaper.png;
		};
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = mod;
        defaultWorkspace = "workspace number 1";
        startup = [
          {
            command = "${pkgs.keepassxc}/bin/keepassxc";
            notification = false;
          }
          {
            command = "${pkgs.blueman}/bin/blueman-applet";
            notification = false;
          }
        ];
        keybindings = {
          "${mod}+c" = "kill";
          "${mod}+m" = "fullscreen toggle";

          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";
          "${mod}+s" = "split vertical, layout stacking";
          "${mod}+v" = "split vertical";
          "${mod}+b" = "split horizontal";
          "${mod}+w" = "layout tabbed";
          "${mod}+n" = "layout toggle split";
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";

          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+10" = "workspace number 10";
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+10" = "move container to workspace number 10";

          "${mod}+q" = "exec --no-startup-id ${pkgs.firefox}/bin/firefox";
          "${mod}+p" = "exec --no-startup-id ${pkgs.dmenu}/bin/dmenu_run";
          "${mod}+e" =
            "exec --no-startup-id ${pkgs.gnome.nautilus}/bin/nautilus";
          "${mod}+Return" =
            "exec --no-startup-id ${pkgs.alacritty}/bin/alacritty";

          "XF86AudioRaiseVolume" =
            "exec wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && $refresh_i3_status";
          "XF86AudioLowerVolume" =
            "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && $refresh_i3_status";
          "XF86AudioMute" =
            "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && $refresh_i3_status";
          "XF86AudioMicMute" =
            "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && $refresh_i3_status";
        };
        bars = [{ statusCommand = "i3status"; }];
      };
      extraConfig = ''
        focus_follows_mouse no
      '';
    };
  };
}

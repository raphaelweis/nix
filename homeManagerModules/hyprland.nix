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
      ];
      sessionVariables.NIXOS_OZONE_WL = "1";
    };
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        bind = [
          "ALT, space, exec, rofi -show drun"
          "$mod, return, exec, ghostty"
          "$mod, w, killactive"
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
      };
    };
  };
}

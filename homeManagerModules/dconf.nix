{
  lib,
  pkgs,
  ...
}:
{
  options.rw = {
    dconf.enable = lib.mkEnableOption "dconf (gnome and gnome extensions) configuration.";
  };
  config =
    let
      mkTuple = lib.hm.gvariant.mkTuple;
    in
    {
      home.packages = with pkgs.gnomeExtensions; [
        no-titlebar-when-maximized
        appindicator
        dash-to-dock
      ];
      dconf.settings = {
        "org/gnome/shell" = {
          enabled-extensions = with pkgs.gnomeExtensions; [
            no-titlebar-when-maximized.extensionUuid
            appindicator.extensionUuid
            dash-to-dock.extensionUuid
          ];
          favorite-apps = [
            "zen-twilight.desktop"
            "Alacritty.desktop"
            "code.desktop"
            "discord.desktop"
            "spotify.desktop"
          ];
        };
        "org/gnome/shell/app-switcher" = {
          current-workspace-only = true;
        };
        "org/gnome/desktop/input-sources" = {
          sources = [
            (mkTuple [
              "xkb"
              "us+intl"
            ])
          ];
        };
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          show-battery-percentage = true;
          enable-hot-corners = false;
        };
        "org/gnome/desktop/peripherals/mouse" = {
          accel-profile = "flat";
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          ];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Super>e";
          command = "nautilus --new-window";
          name = "Nautilus";
        };
        "org/gnome/desktop/background" = {
          color-shading-type = "solid";
          picture-options = "zoom";
          picture-uri = "file://${../assets/the_solo_traveller_wallpaper_laptop.png}";
          picture-uri-dark = "file://${../assets/the_solo_traveller_wallpaper_laptop.png}";
          primary-color = "#241f31";
          secondary-color = "#000000";
        };
        "org/gnome/shell/extensions/unite" = {
          extend-left-box = false;
          notifications-position = "center";
        };
        "org/gnome/shell/extensions/dash-to-dock" = {
          dock-position = "RIGHT";
          extend-height = true;
          dock-fixed = true;
          dash-max-icon-size = 24;
          custom-theme-shrink = true;
          show-trash = false;
          always-center-icons = true;
          custom-background-color = true;
          background-color = "rgb(0, 0, 0)";
          transparency-mode = "DYNAMIC";
        };
      };
    };
}

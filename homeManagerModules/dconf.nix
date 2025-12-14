{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.rw.dconf = {
    enable = lib.mkEnableOption "dconf (gnome and gnome extensions) configuration.";
    wallpaper = lib.mkOption {
      type = lib.types.path;
      default = ../resources/assets/the_solo_traveller_wallpaper_desktop.png;
      description = "An image to set as the gnome wallpaper.";
    };
  };
  config =
    let
      mkTuple = lib.hm.gvariant.mkTuple;
    in
    lib.mkIf config.rw.dconf.enable {
      home.packages = with pkgs.gnomeExtensions; [
        appindicator
      ];
      dconf.settings = {
        "org/gnome/shell" = {
          enabled-extensions = with pkgs.gnomeExtensions; [
            appindicator.extensionUuid
          ];
          favorite-apps = [
            "zen-twilight.desktop"
            "com.mitchellh.ghostty.desktop"
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
          # color-scheme = "prefer-light";
          show-battery-percentage = true;
          enable-hot-corners = false;
        };
        "org/gnome/desktop/peripherals/mouse" = {
          accel-profile = "flat";
        };
        "org/gnome/shell/keybindings" = {
          "show-screenshot-ui" = [ "<Shift><Super>s" ];
          "screenshot" = [ "Print" ];
          "toggle-overview" = [ "<Alt>space" ];
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
          picture-uri = "file://${config.rw.dconf.wallpaper}";
          picture-uri-dark = "file://${config.rw.dconf.wallpaper}";
          primary-color = "#241f31";
          secondary-color = "#000000";
        };
        "org/gnome/shell/extensions/unite" = {
          extend-left-box = false;
          notifications-position = "center";
        };
      };
    };
}

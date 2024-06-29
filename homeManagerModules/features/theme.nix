{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    theme = {
      enable = lib.mkEnableOption
        "theme configuration elements such as gtk theme and cursor theme.";
      cursorSize = lib.mkOption {
        type = lib.types.int;
        default = 20;
        description = "Cursor size to set using home.pointerCursor.size.";
      };
    };
  };
  config = lib.mkIf config.rFeatures.theme.enable {
    dconf.settings = {
      "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
    };
    gtk = {
      enable = true;
      theme.name = "Adwaita";
      gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    };
    home.pointerCursor = {
      name = "Capitaine Cursors - White";
      package = pkgs.capitaine-cursors-themed;
      size = config.rFeatures.theme.cursorSize;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}

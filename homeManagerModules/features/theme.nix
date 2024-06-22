{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    gtk.enable = lib.mkEnableOption "Enables and configures gtk";
  };
  config = lib.mkIf config.rFeatures.gtk.enable {
    dconf.settings = {
      "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
    };
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome.gnome-themes-extra;
      };
      cursorTheme = {
        name = "Capitaine Cursors (Gruvbox) - Black";
        package = pkgs.capitaine-cursors-themed;
      };
    };
  };
}

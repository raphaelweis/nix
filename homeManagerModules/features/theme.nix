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
    };
    home.pointerCursor = {
      name = "Capitaine Cursors (Gruvbox) - White";
      package = pkgs.capitaine-cursors-themed;
      size = 20;

      gtk.enable = true;
      x11.enable = true;
    };
  };
}

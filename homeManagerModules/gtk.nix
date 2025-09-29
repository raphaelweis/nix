{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.rw.gtk = {
    enable = lib.mkEnableOption "GTK configuration";
  };
  config = lib.mkIf config.rw.gtk.enable {
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita";
        package = pkgs.libadwaita;
      };
      gtk3 = {
        extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };
      };
      gtk4 = {
        extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };
      };
    };
  };
}

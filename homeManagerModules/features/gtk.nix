{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.rFeatures.gtk.enable = lib.mkEnableOption "gtk (UI toolkit)";
  config = lib.mkIf config.rFeatures.gtk.enable {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Gruvbox-Plus-Dark";
        package = pkgs.gruvbox-plus-icons;
      };
    };
  };
}

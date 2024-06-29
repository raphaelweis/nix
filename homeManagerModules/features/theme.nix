{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    theme.enable = lib.mkEnableOption "theme configuration elements";
  };
  config = lib.mkIf config.rFeatures.theme.enable {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Gruvbox-Plus-Dark";
        package = pkgs.gruvbox-plus-icons;
      };
    };
  };
}

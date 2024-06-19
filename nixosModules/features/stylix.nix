{ lib, config, inputs, pkgs, ... }: {
  options.rFeatures = {
    stylix.enable = lib.mkEnableOption "enables and configures stylix";
  };

  config = lib.mkIf config.rFeatures.stylix.enable {
    stylix = {
      enable = true;
      image = ../../assets/wallpaper.png;
      base16Scheme =
        "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
      fonts = {
        monospace = {
          package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
          name = "JetBrainsMono Nerd Font";
        };
        sizes = {
          applications = 12;
          desktop = 10;
        };
      };
      cursor.size = 24;
      targets.plymouth.enable = false;
    };
  };
}

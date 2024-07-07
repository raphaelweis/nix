{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    stylix.enable = lib.mkEnableOption "stylix global theming";
  };

  config = lib.mkIf config.rFeatures.stylix.enable {
    stylix = {
      enable = true;
      polarity = "dark";
      image = ../../assets/wallpaper.png;
      base16Scheme =
        "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
      targets = {
        nixvim.enable = false;
        waybar.enable = false;
        rofi.enable = false;
      };
      cursor = {
        name = "Capitaine Cursors - White";
        package = pkgs.capitaine-cursors-themed;
        size = 24;
      };
      fonts = {
        sizes.applications = 10;
        monospace = {
          package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
          name = "JetBrainsMonoNL NF";
        };
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}

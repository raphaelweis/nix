{ lib, config, pkgs, vars, ... }: {
  options.rFeatures = {
    stylix.enable = lib.mkEnableOption "stylix global theming";
  };

  config = lib.mkIf config.rFeatures.stylix.enable {
    stylix = {
      enable = true;
      polarity = "dark";
      image = ../../assets/wallpaper.png;
      base16Scheme = vars.base16Theme;
      targets = {
        waybar.enable = false;
        rofi.enable = false;
      	neovim.enable = false;
	      nixvim.enable = false;
        firefox.enable = false;
        hyprland.enable = true;
        hyprpaper.enable = true;
      };
      cursor = {
        name = "macOS";
        package = pkgs.apple-cursor;
        size = 24;
      };
      fonts = {
        sizes.applications = 10;
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono NF";
        };
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}

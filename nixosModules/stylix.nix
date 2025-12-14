{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.rw = {
    stylix.enable = lib.mkEnableOption "stylix theme management system";
  };
  config = lib.mkIf config.rw.stylix.enable {
    stylix = {
      enable = true;

      base16Scheme = {
        base00 = "F7FBF1"; # background
        base01 = "F1F5EC"; # surfaceContainerLow
        base02 = "ECEFE6"; # surfaceContainer
        base03 = "DEE5D8"; # surfaceVariant
        base04 = "72796F"; # outline
        base05 = "181D17"; # onSurface
        base06 = "E0E4DB"; # inverseOnSurface
        base07 = "10140F"; # inverseSurface

        base08 = "BA1A1A"; # error
        base09 = "38656A"; # tertiary
        base0A = "52634F"; # secondary
        base0B = "3B693A"; # primary
        base0C = "BCEBF1"; # tertiaryContainer
        base0D = "3B693A"; # primary (dark variant)
        base0E = "D5E8CF"; # secondaryContainer
        base0F = "FFDAD6"; # errorContainer
      };
      fonts = {
        serif = {
          package = pkgs.roboto-serif;
          name = "Roboto Serif";
        };

        sansSerif = {
          package = pkgs.roboto;
          name = "Roboto";
        };

        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMonoNL Nerd Font";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}

{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    rofi.enable = lib.mkEnableOption "enables and configures rofi";
  };
  config = lib.mkIf config.rFeatures.rofi.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      plugins = with pkgs;
        [ (rofi-calc.override { rofi-unwrapped = rofi-wayland-unwrapped; }) ];
      extraConfig = {
        icon-theme = "Gruvbox-Plus-Dark";
        display-drun = "APP ";
        display-run = "CMD ";
        display-calc = "CAL ";
        show-icons = false;
      };
      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
        c = config.lib.stylix.colors;
      in {
        "*" = {
          bg0 = mkLiteral "#${c.base00}";
          bg1 = mkLiteral "#${c.base01}";
          fg0 = mkLiteral "#${c.base06}";
          border = mkLiteral "#${c.base0D}";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@fg0";
        };

        "window" = {
          background-color = mkLiteral "@bg0";
          border = mkLiteral "2px";
          border-color = mkLiteral "@border";
          border-radius = mkLiteral "10px";
        };

        "element" = {
          padding = mkLiteral "0.5em";
          spacing = mkLiteral "1em";
        };
        "element selected".background-color = mkLiteral "@bg1";

        "element-icon".size = mkLiteral "3em";

        "element-text" = {
          vertical-align = mkLiteral "0.5";
          highlight = mkLiteral "underline #${c.base09}";
        };

        "inputbar".padding = mkLiteral "0.5em";

        "listview" = {
          lines = 5;
          columns = 1;
        };
      };
    };
  };
}

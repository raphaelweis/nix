{ lib, config, pkgs, ... }: {
  options.rFeatures.rofi = {
    enable = lib.mkEnableOption "enables and configures rofi";
    width = lib.mkOption {
      type = lib.types.int;
      default = 20;
      description = "The width to set for the rofi window, as a percentage of the full screen width.";
    };
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
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "#${c.base06}";
        };

        "window" = {
          background-color = mkLiteral "#${c.base00}E6";
          border = mkLiteral "2px";
          border-color = mkLiteral "#${c.base0D}";
          border-radius = mkLiteral "10px";
          width = mkLiteral "20%";
        };

        "element" = {
          padding = mkLiteral "0.5em";
          spacing = mkLiteral "1em";
        };
        "element selected".background-color = mkLiteral "#${c.base01}";

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

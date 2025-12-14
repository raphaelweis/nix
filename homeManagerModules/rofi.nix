{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  options.rw = {
    rofi.enable = lib.mkEnableOption "rofi (launcher) configuration";
  };

  config = lib.mkIf config.rw.rofi.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi;

      modes = [
        "run"
        "drun"
      ];

      cycle = true;
      location = "center";

      extraConfig = {
        show-icons = true;
      };

      theme = {
        "*" = {
          font = "sans 14";
        };

        "window" = {
          padding = mkLiteral "24px";
        };

        "mainbox" = {
          padding = mkLiteral "12px";
          spacing = mkLiteral "12px";
        };

        "inputbar" = {
          padding = mkLiteral "12px";
          spacing = mkLiteral "10px";
        };

        "listview" = {
          padding = mkLiteral "12px";
          spacing = mkLiteral "8px";
        };

        "element" = {
          padding = mkLiteral "10px 14px";
        };

        "element-icon" = {
          size = mkLiteral "1.2em";
        };

        "element-text" = {
          padding = mkLiteral "0px 6px";
        };
      };
    };
  };
}

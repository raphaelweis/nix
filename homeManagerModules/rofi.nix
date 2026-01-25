{
  pkgs,
  lib,
  config,
  ...
}:
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
      # theme =
      #   let
      #     inherit (config.lib.formats.rasi) mkLiteral;
      #     c = config.lib.stylix.colors.withHashtag;
      #   in
      #   {
      #     "*" = {
      #       font = "sans 14";
      #
      #       background-color = mkLiteral "transparent";
      #
      #       margin = mkLiteral "0px";
      #       padding = mkLiteral "0px";
      #       spacing = mkLiteral "0px";
      #     };
      #
      #     "window" = {
      #       location = mkLiteral "center";
      #       height = 512;
      #       width = 512;
      #       border-radius = mkLiteral "24px";
      #
      #       background-color = mkLiteral c.base02;
      #     };
      #
      #     "mainbox" = {
      #       padding = mkLiteral "12px";
      #     };
      #
      #     "inputbar" = {
      #       background-color = mkLiteral c.base01;
      #       border-color = mkLiteral c.base03;
      #
      #       border = 2;
      #       border-radius = mkLiteral "16px";
      #
      #       padding = mkLiteral "8px 16px";
      #       spacing = mkLiteral "8px";
      #       children = map mkLiteral [
      #         "prompt"
      #         "entry"
      #       ];
      #     };
      #
      #     "prompt" = {
      #       text-color = mkLiteral c.base04;
      #     };
      #
      #     "entry" = {
      #       placeholder = "Search";
      #       placeholder-color = mkLiteral c.base04;
      #       text-color = mkLiteral c.base05;
      #     };
      #
      #     "message" = {
      #       margin = mkLiteral "12px 0 0";
      #       border-radius = mkLiteral "16px";
      #       border-color = mkLiteral c.base02;
      #       background-color = mkLiteral c.base02;
      #     };
      #
      #     "textbox" = {
      #       padding = mkLiteral "16px 24px";
      #     };
      #
      #     "listview" = {
      #       background-color = mkLiteral "transparent";
      #
      #       margin = mkLiteral "12px 0 0";
      #       lines = 8;
      #       columns = 1;
      #
      #       fixed-height = false;
      #     };
      #
      #     "element" = {
      #       padding = mkLiteral "16px 16px";
      #       spacing = mkLiteral "8px";
      #       border-radius = mkLiteral "16px";
      #     };
      #
      #     "element-text" = {
      #       text-color = mkLiteral c.base05;
      #     };
      #
      #     "element-text selected normal, element-text selected active" = {
      #       text-color = mkLiteral c.base03;
      #     };
      #
      #     "element selected normal, element selected active" = {
      #       background-color = mkLiteral c.base0B;
      #     };
      #
      #     "element-icon" = {
      #       size = mkLiteral "1em";
      #       vertical-align = mkLiteral "0.5";
      #     };
      #   };
    };
  };
}

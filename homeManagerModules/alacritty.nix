{ lib, config, ... }:
{
  options.rw = {
    alacritty.enable = lib.mkEnableOption "Alacritty configuration.";
  };
  config = lib.mkIf config.rw.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          normal = {
            family = "monospace";
            style = "Regular";
          };
          bold = {
            style = "Bold";
          };
          italic = {
            style = "Italic";
          };
          bold_italic = {
            style = "Bold Italic";
          };
          size = 12;
        };
        mouse = {
          hide_when_typing = true;
        };
        window = {
          decorations = "None";
          startup_mode = "Maximized";
        };

        # Vague for Alacritty
        # -------------------
        # Theme Author: vague2k <ilovedrawing056@gmail.com>
        # Ported by:	skewb1k <skewb1kunix@gmail.com>
        # License:  	MIT License
        # Upstream: 	https://github.com/vague2k/vague.nvim/blob/main/extras/alacritty/vague.toml
        colors = {
          primary = {
            background = "#141415";
            foreground = "#cdcdcd";
          };
          normal = {
            black = "#252530";
            red = "#d8647e";
            green = "#7fa563";
            yellow = "#f3be7c";
            blue = "#6e94b2";
            magenta = "#bb9dbd";
            cyan = "#aeaed1";
            white = "#cdcdcd";
          };
          bright = {
            black = "#606079";
            red = "#e08398";
            green = "#99b782";
            yellow = "#f5cb96";
            blue = "#90a0b5";
            magenta = "#c9b1ca";
            cyan = "#bebeda";
            white = "#d7d7d7";
          };
        };
      };
    };
  };
}

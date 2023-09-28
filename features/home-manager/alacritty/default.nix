{ vars, config, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = with config.colorScheme.colors; {
        bright = {
          black = "0x${base03}";
          blue = "0x${base0D}";
          cyan = "0x${base0C}";
          green = "0x${base0B}";
          magenta = "0x${base0E}";
          red = "0x${base08}";
          white = "0x${base06}";
          yellow = "0x${base09}";
        };
        normal = {
          black = "0x${base00}";
          blue = "0x${base0D}";
          cyan = "0x${base0C}";
          green = "0x${base0B}";
          magenta = "0x${base0E}";
          red = "0x${base08}";
          white = "0x${base06}";
          yellow = "0x${base0A}";
        };
        primary = {
          background = "0x${base00}";
          foreground = "0x${base06}";
        };
      };
      mouse = {
        hide_when_typing = true;
      };
      cursor.style = {
        blinking = "Off";
        shape = "Block";
      };
      draw_bold_text_with_bright_colors = true;
      font = {
        bold = {
          family = "${vars.fonts.system-font}";
          style = "Bold";
        };
        bold_italic = {
          family = "${vars.fonts.system-font}";
          style = "BoldItalic";
        };
        italic = {
          family = "${vars.fonts.system-font}";
          style = "MediumItalic";
        };
        normal = {
          family = "${vars.fonts.system-font}";
          style = "Regular";
        };
        size = vars.programs.alacritty.font-size;
      };
      window = {
        startup_mode = "Maximized";
        opacity = vars.programs.alacritty.opacity;
        padding = {
          x = 10;
          y = 10;
        };
      };
      env = {
        WINIT_X11_SCALE_FACTOR = "1";
        TERM = "xterm-256color";
      };
    };
  };
}

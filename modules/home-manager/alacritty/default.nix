{ host, ... }:
let
  vars = import ../../../hosts/home-manager/${host}/vars.nix;
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = "0x282828";
          foreground = "0xe5e5e5";
        };
        normal = {
          black = "0x282828";
          red = "0xcc241d";
          green = "0x98971a";
          yellow = "0xd79921";
          blue = "0x458588";
          magenta = "0xb16286";
          cyan = "0x689d6a";
          white = "0xa89984";
        };
        bright = {
          black = "0x928374";
          red = "0xfb4934";
          green = "0xb8bb26";
          yellow = "0xfabd2f";
          blue = "0x83a598";
          magenta = "0xd3869b";
          cyan = "0x8ec07c";
          white = "0xebdbb2";
        };
      };
      mouse = {
        hide_when_typing = true;
      };
      cursor = {
        style = {
          blinking = "Off";
          shape = "Block";
        };
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
        size = vars.programs.terminal.font-size;
      };
      window = {
        startup_mode = "Maximized";
        opacity = vars.programs.terminal.opacity;
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

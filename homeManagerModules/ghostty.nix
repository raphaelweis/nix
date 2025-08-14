{ lib, ... }:
{
  options.rw = {
    ghostty.enable = lib.mkEnableOption "ghostty configuration.";
  };
  config = {
    programs.ghostty = {
      enable = true;
      settings = {
        command = "tmux attach";
        confirm-close-surface = false;
        theme = "vague";
        font-family = "monospace";
        font-size = 14;
        shell-integration-features = "no-cursor";
        cursor-style = "block";
        cursor-style-blink = false;
        gtk-titlebar-hide-when-maximized = true;
        maximize = true;
        gtk-single-instance = true;
        keybind = [
          "ctrl+enter=unbind"
        ];
      };
      themes = {
        # Vague for Ghostty
        # -------------------
        # Theme Author: vague2k <ilovedrawing056@gmail.com>
        # Ported by:	skewb1k <skewb1kunix@gmail.com>
        # License:  	MIT License
        # Upstream: 	https://github.com/vague2k/vague.nvim/blob/main/extras/ghostty/vague
        vague = {
          palette = [
            "0=#252530"
            "1=#d8647e"
            "2=#7fa563"
            "3=#f3be7c"
            "4=#6e94b2"
            "5=#bb9dbd"
            "6=#aeaed1"
            "7=#cdcdcd"
            "8=#606079"
            "9=#e08398"
            "10=#99b782"
            "11=#f5cb96"
            "12=#90a0b5"
            "13=#c9b1ca"
            "14=#bebeda"
            "15=#d7d7d7"
          ];
          background = "#141415";
          foreground = "#cdcdcd";
          cursor-color = "#cdcdcd";
          selection-background = "#252530";
          selection-foreground = "#cdcdcd";
        };
      };
    };
  };
}

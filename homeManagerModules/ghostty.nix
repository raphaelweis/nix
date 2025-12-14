{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.rw.ghostty = {
    enable = lib.mkEnableOption "ghostty configuration.";
    fontSize = lib.mkOption {
      type = lib.types.int;
      default = 12;
      description = "Set the default font size.";
    };
  };
  config = lib.mkIf config.rw.ghostty.enable {
    programs.ghostty = {
      enable = true;
      package = if pkgs.stdenv.isLinux then pkgs.ghostty else null;
      settings = {
        background-opacity = 1;
        confirm-close-surface = true;
        theme = "GitHub Dark Default";
        background = "0A0A0A";
        font-family = "monospace";
        font-size = config.rw.ghostty.fontSize;
        window-padding-x = 5;
        window-padding-y = 5;
        shell-integration-features = "no-cursor";
        cursor-style = "block";
        cursor-style-blink = false;
        cursor-invert-fg-bg = true;
        adjust-cursor-thickness = 1;
        gtk-titlebar-hide-when-maximized = true;
        gtk-single-instance = true;
        keybind = [
          "ctrl+enter=unbind"
          "performable:alt+c=copy_to_clipboard"
          "performable:alt+v=paste_from_clipboard"
        ];
      };
    };
  };
}

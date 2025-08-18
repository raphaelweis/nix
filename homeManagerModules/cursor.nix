{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.rw.cursor = {
    enable = lib.mkEnableOption "pointer cursor configuration";
    cursorSize = lib.mkOption {
      type = lib.types.int;
      default = 24;
      description = "set the cursor size";
    };
    x11CursorSize = lib.mkOption {
      type = lib.types.int;
      default = config.rw.cursor.cursorSize;
      description = "set a different x11 cursor size than the normal cursor size. Useful for HiDPI screens.";
    };
  };
  config =
    let
      themeName = "macOS";
    in
    {
      home.pointerCursor = {
        enable = true;
        package = pkgs.apple-cursor;
        name = themeName;
        size = config.rw.cursor.x11CursorSize;
        dotIcons.enable = true;
        gtk.enable = true;
      };
      dconf = {
        enable = true;
        settings."org/gnome/desktop/interface" = {
          cursor-theme = themeName;
          cursor-size = config.rw.cursor.cursorSize;
        };
      };
    };
}

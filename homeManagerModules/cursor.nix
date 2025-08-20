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
        size = config.rw.cursor.cursorSize;
      };
      dconf = {
        enable = true;
        settings."org/gnome/desktop/interface" = {
          cursor-theme = themeName;
        };
      };
    };
}

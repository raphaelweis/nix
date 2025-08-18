{ config, ... }:
let
  username = "raphaelw";
in
{
  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  rw = {
    # Screen scale is 2 so double the size of the xcursor.
    cursor = {
      cursorSize = 24;
      x11CursorSize = 48;
    };
  };
}

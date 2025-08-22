{ ... }:
let
  username = "raphaelw";
in
{
  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  rw = {
    dconf = {
      wallpaper = ../../../assets/the_solo_traveller_wallpaper_laptop.png.png;
    };
    cursor = {
      cursorSize = 24;
      x11CursorSize = 48;
    };
  };
}

{ username, ... }:
{
  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  rw = {
    dconf = {
      wallpaper = ../../../resources/assets/the_solo_traveller_wallpaper_laptop.png;
    };
  };
}

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wine
    wineWowPackages.stable
    winetricks
    wineWowPackages.waylandFull
  ];
}

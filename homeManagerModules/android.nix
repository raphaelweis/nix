{ lib, pkgs, ... }:
{
  options.rw = {
    android.enable = lib.mkEnableOption "android-studio and android development tools configuration.";
  };
  config = {
    home.packages = with pkgs; [
      android-studio
    ];
  };
}

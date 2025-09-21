{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.rw = {
    android.enable = lib.mkEnableOption "android-studio and android development tools configuration.";
  };
  config = lib.mkIf config.rw.android.enable {
    home.packages = with pkgs; [
      android-studio
    ];
  };
}

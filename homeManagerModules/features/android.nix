{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.rFeatures.android.enable = lib.mkEnableOption "android (android-studio, adb, android-sdk)";

  config = lib.mkIf config.rFeatures.android.enable {
    home.packages = with pkgs; [
      android-studio
      android-tools
    ];
  };
}

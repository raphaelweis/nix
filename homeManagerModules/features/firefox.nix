{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.rFeatures = {
    firefox.enable = lib.mkEnableOption "Firefox";
  };

  config = lib.mkIf config.rFeatures.firefox.enable {
    home.sessionVariables.MOZ_USE_XINPUT2 = "1";

    programs.firefox = {
      enable = true;
      package = (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true; }) { });
    };
  };
}

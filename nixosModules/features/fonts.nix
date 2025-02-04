{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.rFeatures = {
    fonts.enable = lib.mkEnableOption "Font and fontconfig configuration for the system.";
  };

  config = lib.mkIf config.rFeatures.fonts.enable {
    fonts = {
      packages = [ pkgs.nerd-fonts.jetbrains-mono ];
      fontconfig = {
        enable = true;
        defaultFonts.monospace = [ "JetBrainsMono NF" ];
      };
    };
  };
}

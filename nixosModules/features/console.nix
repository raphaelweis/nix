{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.rFeatures = {
    console = {
      enable = lib.mkEnableOption "Console (TTY) configuration for the system";
      font = lib.mkOption {
        type = lib.types.str;
        default = "Lat2-Terminus16";
        description = "The font to set for the kernel console";
      };
    };
  };

  config = lib.mkIf config.rFeatures.console.enable {
    environment.systemPackages = with pkgs; [ terminus_font ];
    console = {
      font = config.rFeatures.console.font;
      useXkbConfig = true;
    };
  };
}

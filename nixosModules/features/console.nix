{ lib, config, ... }: {
  options.rFeatures = {
    console.enable =
      lib.mkEnableOption "Console (TTY) configuration for the system";
  };

  config = lib.mkIf config.rFeatures.console.enable {
    console = {
      font = "Lat2-Terminus16";
      useXkbConfig = true;
    };
  };
}

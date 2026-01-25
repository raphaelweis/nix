{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options.rw = {
    dms.enable = lib.mkEnableOption "Dank Material Shell configuration";
  };
  config = lib.mkIf config.rw.dms.enable {
    programs.dms-shell = {
      enable = true;
      quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;

      systemd = {
        enable = true;
        restartIfChanged = true;
      };

      enableSystemMonitoring = true;
      enableVPN = true;
      enableDynamicTheming = true;
      enableAudioWavelength = true;
      enableCalendarEvents = true;
    };

    services.displayManager.dms-greeter = {
      enable = true;
      compositor.name = "niri";
    };
  };
}

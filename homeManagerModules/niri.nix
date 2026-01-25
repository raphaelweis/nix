{ lib, config, ... }:
{
  options.rw.niri = {
    enable = lib.mkEnableOption "Niri wayland compositor configuration";
  };
  config = lib.mkIf config.rw.niri.enable {
    xdg.configFile."niri" = {
      source = ./raw/niri;
      recursive = true;
    };
  };
}

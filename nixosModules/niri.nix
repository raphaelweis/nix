{ lib, config, pkgs, ... }:
{
  options.rw = {
    niri.enable = lib.mkEnableOption "Niri the wayland compositor";
  };
  config = lib.mkIf config.rw.niri.enable {
    programs.niri.enable = true;
    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];
  };
}

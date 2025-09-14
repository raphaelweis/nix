{ pkgs, lib, ... }:
{
  options.rw = {
    rofi.enable = lib.mkEnableOption "rofi (launcher) configuration";
  };
  config = {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi;
      modes = [
        "run"
        "drun"
      ];
      cycle = true;
      font = "monospace 12";
      location = "center";
      extraConfig = {
        show-icons = true;
      };
    };
  };
}

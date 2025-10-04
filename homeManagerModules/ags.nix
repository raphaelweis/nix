{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:
{
  options.rw.ags = {
    enable = lib.mkEnableOption "Ags configuration.";
  };
  config = lib.mkIf config.rw.ags.enable {
    home.packages = [ inputs.astal.packages.${pkgs.system}.io ];
    programs.ags = {
      enable = true;
      configDir = ../resources/ags;
    };
  };
}

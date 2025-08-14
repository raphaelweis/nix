{ lib, pkgs, ... }:
{
  options.rw = {
    fonts.enable = lib.mkEnableOption "fonts and fontconfig configuration.";
  };
  config = {
    home.packages = with pkgs; [
      dejavu_fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
    ];
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "DejaVu Serif" ];
        sansSerif = [ "DejaVu Sans" ];
        monospace = [ "JetBrainsMonoNL Nerd Font" ];
      };
    };
  };
}

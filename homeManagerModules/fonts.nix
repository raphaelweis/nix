{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.rw = {
    fonts.enable = lib.mkEnableOption "fonts and fontconfig configuration.";
  };
  config = lib.mkIf config.rw.fonts.enable {
    home.packages = with pkgs; [
      dejavu_fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      (pkgs.stdenvNoCC.mkDerivation {
        pname = "custom-fonts";
        version = "1.0";
        src = ../resources/assets/fonts;
        installPhase = ''
          mkdir -p $out/share/fonts/truetype
          cp *.ttf $out/share/fonts/truetype/ 2>/dev/null || true
        '';
      })
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

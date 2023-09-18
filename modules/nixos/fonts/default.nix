{ pkgs, ... }:
{
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us-acentos";
  };

  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
    fontconfig = {
      enable = true;
      useEmbeddedBitmaps = true;
      defaultFonts = {
        monospace = [ "JetBrainsMonoNL Nerd Font" ];
      };
    };
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
    packages = with pkgs; [
      dejavu_fonts
      font-awesome
      corefonts
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
        ];
      })
    ];
  };
}

{
  lib,
  config,
  ...
}:
{
  options.rw = {
    tofi.enable = lib.mkEnableOption "tofi (dmenu-like launcher) configuration.";
  };
  config = lib.mkIf config.rw.tofi.enable {
    programs.tofi = {
      enable = true;
      settings = {
        # Directly providing the path to the font file massively improves startup time.
        # font = "${pkgs.nerd-fonts.jetbrains-mono}/share/fonts/truetype/NerdFonts/JetBrainsMono/JetBrainsMonoNLNerdFont-Regular.ttf";
        width = "100%";
        height = "100%";
        border-width = 0;
        outline-width = 0;
        padding-left = "35%";
        padding-top = "35%";
        result-spacing = "25";
        num-results = "5";
        # selection-color = "#ffffff";
        # selection-background = "#285577";
        selection-background-padding = "4,10";
        # background-color = "#000A";
        # text-color = "#888888";
        # input-color = "#ffffff";
      };
    };
  };
}

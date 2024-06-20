{ lib, config, ... }: {
  options.rFeatures = {
    alacritty.enable = lib.mkEnableOption "enables and configures alacritty";
  };
  config = lib.mkIf config.rFeatures.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        font.normal.family = "JetBrainsMonoNL NF";
        colors.primary.background = "#1d2021";
      };
    };
  };
}

{ lib, config, ... }: {
  options.rFeatures = {
    alacritty.enable = lib.mkEnableOption "enables and configures alacritty";
  };
  config = lib.mkIf config.rFeatures.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          size = 12;
          normal.family = "JetBrainsMonoNL NF";
        };
				mouse.hide_when_typing = true;
        colors.primary.background = "#1d2021";
        env."WINIT_X11_SCALE_FACTOR" = "1";
      };
    };
  };
}

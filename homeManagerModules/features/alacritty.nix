{ lib, config, inputs, ... }: {
  options.rFeatures = {
    alacritty.enable = lib.mkEnableOption "enables and configures alacritty";
  };

  config = lib.mkIf config.rFeatures.alacritty.enable {
    programs.alacritty = {
      enable = true;
    };
  };
}

{ lib, config, ... }: {
  options.rFeatures = {
    hyperland.enable = lib.mkEnableOption "enables hyperland";
  };

  config = lib.mkIf config.rFeatures.hyperland.enable {
    programs.hyprland.enable = true;
  };
}

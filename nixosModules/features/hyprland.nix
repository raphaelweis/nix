{ lib, config, ... }: {
  options.rFeatures = {
    hyperland.enable = lib.mkEnableOption "Hyprland, the wayland compositor";
  };

  config = lib.mkIf config.rFeatures.hyperland.enable {
    programs.hyprland.enable = true;
  };
}

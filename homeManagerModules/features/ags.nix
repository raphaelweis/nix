{ lib, config, pkgs, ... }: {
  options.rFeatures.ags.enable =
    lib.mkEnableOption "ags (wayland widget toolkit)";

  config = lib.mkIf config.rFeatures.ags.enable {
    programs.ags = {
      enable = true;
      extraPackages = with pkgs; [ gtksourceview webkitgtk accountsservice ];
    };
  };
}

{ lib, config, ... }: {
  options.rFeatures.dconf.enable =
    lib.mkEnableOption "dconf (Gnome settings configuration)";

  config = lib.mkIf config.rFeatures.dconf.enable {
    dconf = {
      enable = true;
      settings = { "org.gnome.desktop.interface".gtk-key-theme = "Emacs"; };
    };
  };
}

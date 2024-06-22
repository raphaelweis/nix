{ lib, config, ... }: {
  options.rFeatures = {
    gdm.enable = lib.mkEnableOption "enables and configures gdm";
  };

  config = lib.mkIf config.rFeatures.gdm.enable {
    services.xserver.displayManager.gdm = {
			enable = true;
			banner = "Got a Benjamin and a Jackson all in my house like i'm Joe, okay";
		};
  };
}

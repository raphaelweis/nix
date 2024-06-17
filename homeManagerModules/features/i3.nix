{ lib, config, inputs, ... }: {
  options.rFeatures = {
    i3.enable = lib.mkEnableOption "enables and configures i3";
  };

  config = lib.mkIf config.rFeatures.i3.enable {
    xsession.windowManager.i3 = {
      enable = true;
			config = {
				modifier = "Mod4";
			};
    };
  };
}

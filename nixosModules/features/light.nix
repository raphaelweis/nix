{ lib, config, vars, ... }: {
  options.rFeatures.light.enable =
    lib.mkEnableOption "light, the backlight control program";

  config = lib.mkIf config.rFeatures.light.enable {
    users.users.${vars.username}.extraGroups = [ "video" ];
    programs.light.enable = true;
    services.actkbd = {
      enable = true;
      bindings = [
        {
          keys = [ 224 ];
          events = [ "key" ];
          command = "/run/current-system/sw/bin/light -U 10";
        }
        {
          keys = [ 225 ];
          events = [ "key" ];
          command = "/run/current-system/sw/bin/light -A 10";
        }
      ];
    };
  };
}

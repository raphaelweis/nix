{
  lib,
  config,
  ...
}:
{
  options.rw = {
    kanshi.enable = lib.mkEnableOption "kanshi (wayland daemon for automatic output configuration) configuration";
  };
  config = lib.mkIf config.rw.kanshi.enable {
    services.kanshi = {
      enable = true;
      settings = [
        {
          profile = {
            name = "docked";

            outputs = [
              {
                criteria = "eDP-1";
                status = "disable";
              }
              {
                criteria = "DP-1";
                status = "enable";
                mode = "3440x1440@100Hz";
                position = "0,0";
              }
            ];
          };
        }

        {
          profile = {
            name = "laptop";

            outputs = [
              {
                criteria = "eDP-1";
                status = "enable";
                scale = 1.9166666;
              }
            ];
          };
        }
      ];
    };
  };
}

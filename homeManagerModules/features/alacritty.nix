{ lib, config, ... }:
{
  options.rFeatures.alacritty = {
    enable = lib.mkEnableOption "the alacritty terminal emulator";
    fontSize = lib.mkOption {
      type = lib.types.int;
      default = 12;
      description = "The font size to use inside the terminal.";
    };
    winitX11ScaleFactor = lib.mkOption {
      type = lib.types.int;
      default = 1;
      description = ''
        The scale factor to set for alacrity. Usually 1, but in the case of a
        high resolution screen, you can set it to 2.
      '';
    };
  };

  config = lib.mkIf config.rFeatures.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          size = lib.mkForce config.rFeatures.alacritty.fontSize;
        };
        mouse.hide_when_typing = true;
        window = {
          opacity = lib.mkForce 1;
          padding = {
            x = 4;
            y = 4;
          };
        };
        env."WINIT_X11_SCALE_FACTOR" = toString config.rFeatures.alacritty.winitX11ScaleFactor;
      };
    };
  };
}

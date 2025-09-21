{ lib, config, ... }:
{
  options.rw = {
    fzf.enable = lib.mkEnableOption "fzf configuration.";
  };
  config = lib.mkIf config.rw.fzf.enable {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

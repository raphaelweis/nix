{ lib, ... }:
{
  options.rw = {
    fzf.enable = lib.mkEnableOption "fzf configuration.";
  };
  config = {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

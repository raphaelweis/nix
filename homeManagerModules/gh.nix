{ lib, config, ... }:
{
  options.rw = {
    gh.enable = lib.mkEnableOption "GitHub CLI configuration.";
  };
  config = lib.mkIf config.rw.gh.enable {
    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}

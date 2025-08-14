{ lib, ... }:
{
  options.rw = {
    gh.enable = lib.mkEnableOption "GitHub CLI configuration.";
  };
  config = {
    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}

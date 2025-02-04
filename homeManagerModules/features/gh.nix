{ lib, config, ... }:
{
  options.rFeatures = {
    gh.enable = lib.mkEnableOption "enables and configures github-cli";
  };

  config = lib.mkIf config.rFeatures.gh.enable {
    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}

{ lib, config, inputs, ... }: {
  options.custom = {
    gh.enable = lib.mkEnableOption "enables and configures github-cli";
  };

  config = lib.mkIf config.custom.gh.enable {
    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}

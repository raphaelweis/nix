{ lib, config, vars, ... }: {
  options.rFeatures = {
    docker.enable = lib.mkEnableOption "Enables and configures docker";
  };

  config = lib.mkIf config.rFeatures.docker.enable {
    users.users.${vars.username}.extraGroups = [ "docker" ];
    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}

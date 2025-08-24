{ lib, ... }:
{
  options.rw = {
    docker.enable = lib.mkEnableOption "Docker";
  };
  config = {
    virtualisation.docker = {
      # disable system docker daemon and instead run docker in rootless mode with
      # user service.
      # https://docs.docker.com/engine/security/rootless/
      enable = false;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}

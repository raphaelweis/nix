{ lib, config, ... }:
{
  options.rw = {
    docker.enable = lib.mkEnableOption "Docker";
  };
  config = lib.mkIf config.rw.docker.enable {
    virtualisation.docker = {
      enable = true;
    };
  };
}

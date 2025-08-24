{ lib, ... }:
{
  options.rw = {
    docker.enable = lib.mkEnableOption "Docker";
  };
  config = {
    virtualisation.docker = {
      enable = true;
    };
  };
}

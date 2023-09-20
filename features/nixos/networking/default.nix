{ vars, ... }:
{
  networking = {
    hostName = vars.hostname;
    networkmanager.enable = true;
  };
}

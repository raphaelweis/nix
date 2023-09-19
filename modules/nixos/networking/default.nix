{ host, ... }:
let
  vars = import ../../../hosts/nixos/${host}/vars.nix;
in
{
  networking = {
    hostName = vars.hostname;
    networkmanager.enable = true;
  };
}

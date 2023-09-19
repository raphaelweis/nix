{ host, ... }:
let
  vars = import ../../../hosts/nixos/${host}/vars.nix;
in
{
  # this is just to make the home-manager module work
  hardware.uinput.enable = true;
  users.groups.uinput.members = [ vars.username ];
  users.groups.input.members = [ vars.username ];
}

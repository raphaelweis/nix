{ vars, ... }:
{
  # this is just to make the home-manager module work
  hardware.uinput.enable = true;
  users.groups.uinput.members = [ vars.username ];
  users.groups.input.members = [ vars.username ];
}

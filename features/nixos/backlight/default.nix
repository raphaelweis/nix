{ vars, ... }:
{
  users.groups.video.members = [ vars.username ];
  programs.light.enable = true;
}

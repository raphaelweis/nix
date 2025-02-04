{
  lib,
  config,
  pkgs,
  vars,
  ...
}:
{
  options.rFeatures = {
    user.enable = lib.mkEnableOption "the default user configuration";
  };

  config = lib.mkIf config.rFeatures.user.enable {
    users.users.${vars.username} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "kvm"
        "adbusers"
        "networkmanager"
        "input"
      ];
      shell = pkgs.zsh;
    };
  };
}

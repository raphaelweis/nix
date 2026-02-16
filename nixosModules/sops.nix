{
  lib,
  config,
  username,
  ...
}:
{
  options.rw = {
    sops.enable = lib.mkEnableOption "sops-nix configuration";
  };
  config = lib.mkIf config.rw.sops.enable {
    sops = {
      defaultSopsFile = ../secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "${config.users.users.${username}.home}/.config/sops/age/keys.txt";

      secrets = {
        # "pgadmin/admin_pwd" = {
        #   owner = "pgadmin";
        #   group = "pgadmin";
        # };
      };
    };
  };
}

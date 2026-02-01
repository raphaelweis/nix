{ lib, config, ... }:
{
  options.rw = {
    postgresql.enable = lib.mkEnableOption "PostgreSQL and PGAdmin 4";
  };
  config = lib.mkIf config.rw.postgresql.enable {
    services = {
      postgresql.enable = true;
      pgadmin = {
        enable = true;
        initialEmail = "admin@localhost.com";
        initialPasswordFile = config.sops.secrets."pgadmin/admin_pwd".path;
      };
    };
  };
}

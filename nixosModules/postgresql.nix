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
        initialEmail = "example@mail.com";
        initialPasswordFile = "/run/secrets/pgadminpassword";
      };
    };
  };
}

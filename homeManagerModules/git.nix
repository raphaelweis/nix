{ lib, config, ... }:
{
  options.rw = {
    git.enable = lib.mkEnableOption "git configuration.";
  };
  config = lib.mkIf config.rw.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          email = "raphael.weis.g@gmail.com";
          name = "Raphaël Weis";
        };
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };
  };
}

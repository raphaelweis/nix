{ lib, ... }:
{
  options.rw = {
    git.enable = lib.mkEnableOption "git configuration.";
  };
  config = {
    programs.git = {
      enable = true;
      userEmail = "raphael.weis.g@gmail.com";
      userName = "Raphaël Weis";
      extraConfig = {
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };
  };
}

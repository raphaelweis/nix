{
  lib,
  config,
  ...
}:
{
  options.rw.starship = {
    enable = lib.mkEnableOption "Starship prompt configuration";
  };
  config = lib.mkIf config.rw.starship.enable {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = true;
        gcloud = {
          disabled = true;
        };
      };
    };
  };
}

{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.rw = {
    guiPkgs.enable = lib.mkEnableOption "a collection of GUI apps to be installed.";
  };
  config = lib.mkIf config.rw.guiPkgs.enable {
    home.packages = with pkgs; [
      spotify
      pavucontrol
      postman
      nautilus
      quickshell
      netflix
      google-chrome
    ];

    programs = {
      vscode = {
        enable = true;
        package = pkgs.vscode.fhs;
      };
    };
  };
}

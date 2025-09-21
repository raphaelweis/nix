{ pkgs, lib, ... }:
{
  options.rw = {
    guiPkgs.enable = lib.mkEnableOption "a collection of GUI apps to be installed.";
  };
  config = {
    home.packages = with pkgs; [
      spotify
      pavucontrol
      postman
      nautilus
    ];

    programs = {
      vscode = {
        enable = true;
        package = pkgs.vscode.fhs;
      };
      zen-browser.enable = true;
    };
  };
}

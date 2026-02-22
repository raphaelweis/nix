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
    home.packages =
      with pkgs;
      [
        spotify
        pavucontrol
        postman
        nautilus
        quickshell
        netflix
        google-chrome
        thunderbird
        zed-editor
        pgadmin4-desktopmode
        zathura
        libreoffice
      ]
      ++ [
        (pkgs.callPackage ./pkgs/helium.nix { })
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

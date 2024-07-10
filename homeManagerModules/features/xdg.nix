{ lib, config, pkgs, ... }:
let
  picturesDir = "${config.home.homeDirectory}/Pictures";
  documentsDir = "${config.home.homeDirectory}/Documents";
  downloadDir = "${config.home.homeDirectory}/Downloads";
  videosDir = "${config.home.homeDirectory}/Videos";
in {
  options.rFeatures.xdg = {
    enable = lib.mkEnableOption "enables and configures xdg directories";
    enableMimeApps = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description =
        "Whether to enable automatic generation of the mimeapps.list file.";
    };
  };
  config = lib.mkIf config.rFeatures.xdg.enable {
    home.packages = with pkgs; [ xdg-utils ];
    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;
        pictures = picturesDir;
        documents = documentsDir;
        download = downloadDir;
        videos = videosDir;
        desktop = null;
        music = null;
        templates = null;
        publicShare = null;
        extraConfig = { XDG_SCREENSHOTS_DIR = "${picturesDir}/Screenshots"; };
      };
      mimeApps = {
        enable = config.rFeatures.xdg.enableMimeApps;
        defaultApplications = {
          "text/html" = [ "firefox.desktop" ];
          "x-scheme-handler/http" = [ "firefox.desktop" ];
          "x-scheme-handler/https" = [ "firefox.desktop" ];
          "x-scheme-handler/ftp" = [ "firefox.desktop" ];
        };
      };
    };
  };
}

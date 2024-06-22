{ lib, config, ... }:
let
  picturesDir = "${config.home.homeDirectory}/Pictures";
  documentsDir = "${config.home.homeDirectory}/Documents";
  downloadDir = "${config.home.homeDirectory}/Downloads";
  videosDir = "${config.home.homeDirectory}/Videos";
in {
  options.rFeatures = {
    xdg.enable = lib.mkEnableOption "enables and configures xdg directories";
  };
  config = lib.mkIf config.rFeatures.xdg.enable {
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
    };
  };
}

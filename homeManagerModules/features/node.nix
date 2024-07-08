{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    node.enable = lib.mkEnableOption "enables and configures fzf";
  };

  config = lib.mkIf config.rFeatures.node.enable {
    home.packages = with pkgs; [ nodejs ];
    home.file.".npmrc".text = ''
      update-notifier=false
    '';
  };
}

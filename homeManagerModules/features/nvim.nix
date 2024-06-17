{ lib, config, inputs, ... }: {
  options.rFeatures = {
    nvim.enable = lib.mkEnableOption "enables and configures neovim";
  };

  config = lib.mkIf config.rFeatures.nvim.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
    };
  };
}

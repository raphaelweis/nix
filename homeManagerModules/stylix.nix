{
  lib,
  config,
  ...
}:
{
  options.rw.stylix = {
    enable = lib.mkEnableOption "Stylix (base 16 theming) configuration";
  };
  config = lib.mkIf config.rw.stylix.enable {
    stylix.targets = {
      vscode.enable = false;
      waybar.enable = false;
      neovim.enable = false;
    };
  };
}

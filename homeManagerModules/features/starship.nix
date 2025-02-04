{
  lib,
  config,
  ...
}:
{
  options.rFeatures.starship.enable = lib.mkEnableOption "ags (wayland widget toolkit)";

  config = lib.mkIf config.rFeatures.starship.enable {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      settings = {
        format = "$all$fill$shell$line_break$character";
        add_newline = false;
        fill = {
          disabled = false;
          symbol = " ";
        };
        shell = {
          disabled = false;
          bash_indicator = "bash";
          zsh_indicator = "zsh";
          pwsh_indicator = "pwsh";
          powershell_indicator = "powershell";
          cmd_indicator = "cmd";
          style = "grey bold";
        };
      };
    };
  };
}

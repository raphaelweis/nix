{ vars, ... }:
{
  imports = [
    (import ../../features/home-manager/alacritty)
    (import ../../features/home-manager/zsh)
    (import ../../features/home-manager/fzf)
    (import ../../features/home-manager/xremap)
    (import ../../features/home-manager/tmux)
    (import ../../features/home-manager/neovim)
  ];

  home = {
    username = vars.username;
    homeDirectory = "/home/${vars.username}";
    stateVersion = "22.11";
    sessionVariables = {
      CHROME_EXECUTABLE = vars.programs.chromium.command;
      BROWSER = vars.programs.chromium.command;
    };
  };

  programs = {
    home-manager.enable = true;
  };
}

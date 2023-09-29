{ vars, ... }:
{
  imports = [
    (import ../../features/home-manager/nix-colors)
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
    stateVersion = "23.05";
    sessionVariables = {
      CHROME_EXECUTABLE = vars.programs.chromium.command;
      BROWSER = vars.programs.chromium.command;
      XDG_DATA_DIRS = "$HOME/.nix-profile/share:/usr/local/share:/usr/share";
    };
  };

  programs = {
    home-manager.enable = true;
  };
}

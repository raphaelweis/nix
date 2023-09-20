{ pkgs, vars, ... }:
{
  imports = [
    (import ../../../modules/home-manager/alacritty)
    (import ../../../modules/home-manager/zsh)
    (import ../../../modules/home-manager/fzf)
    (import ../../../modules/home-manager/xremap)
    (import ../../../modules/home-manager/tmux)
    (import ../../../modules/home-manager/neovim)
  ];

  home = {
    username = vars.username;
    homeDirectory = "/home/${vars.username}";
    stateVersion = "22.11";
    packages = with pkgs; [
      nixgl.auto.nixGLDefault
    ];
    sessionVariables = { };
  };

  programs = {
    home-manager.enable = true;
  };
}

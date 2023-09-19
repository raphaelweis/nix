{ pkgs, ... }:
let
  vars = import ./vars.nix;
in
{
  imports = [
    (import ../../../modules/home-manager/alacritty)
    (import ../../../modules/home-manager/zsh)
    (import ../../../modules/home-manager/fzf)
    (import ../../../modules/home-manager/xremap)
    # (import ../../../modules/home-manager/gh)
    # (import ../../../modules/home-manager/git)
    # (import ../../../modules/home-manager/tmux)
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

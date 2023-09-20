{ pkgs, ... }:
let
  vars = import ./vars.nix;
in
{
  imports = [
    (import ../../../assets)
    (import ../../../modules/home-manager/alacritty)
    (import ../../../modules/home-manager/fzf)
    (import ../../../modules/home-manager/gh)
    (import ../../../modules/home-manager/git)
    (import ../../../modules/home-manager/gnome-keyring)
    (import ../../../modules/home-manager/gtk)
    (import ../../../modules/home-manager/hyprpaper)
    (import ../../../modules/home-manager/swayidle)
    (import ../../../modules/home-manager/tmux)
    (import ../../../modules/home-manager/zsh)
    (import ../../../modules/home-manager/waybar)
    (import ../../../modules/home-manager/swaylock)
    (import ../../../modules/home-manager/hyprland)
    (import ../../../modules/home-manager/xremap)
  ];

  home = {
    username = vars.username;
    homeDirectory = "/home/${vars.username}";
    stateVersion = "22.11";
    packages = with pkgs; [
      bluetuith
      alacritty
      tmux
      starship
      neovim
      lsd
      cliphist
      hyprpaper
      pavucontrol
      vscode
      networkmanagerapplet
      acpi
      gnome.nautilus
      gnome.gnome-themes-extra
      gtk-engine-murrine
      gruvbox-dark-icons-gtk
      discord
      google-chrome
      firefox
    ];
    sessionVariables = {
      EDITOR = vars.programs.editor.command;
      VISUAL = vars.programs.editor.command;
      BROWSER = vars.programs.browser.name;
    };
  };

  programs = {
    home-manager.enable = true;
  };
}
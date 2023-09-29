{ pkgs, vars, ... }:
{
  imports = [
    (import ../../assets)
    (import ../../features/home-manager/nix-colors)
    (import ../../features/home-manager/alacritty)
    (import ../../features/home-manager/fzf)
    (import ../../features/home-manager/gh)
    (import ../../features/home-manager/git)
    (import ../../features/home-manager/gnome-keyring)
    (import ../../features/home-manager/gtk)
    (import ../../features/home-manager/hyprpaper)
    (import ../../features/home-manager/swayidle)
    (import ../../features/home-manager/tmux)
    (import ../../features/home-manager/zsh)
    (import ../../features/home-manager/waybar)
    (import ../../features/home-manager/swaylock)
    (import ../../features/home-manager/hyprland)
    (import ../../features/home-manager/xremap)
    (import ../../features/home-manager/neovim)
    (import ../../features/home-manager/dunst)
    (import ../../features/home-manager/mimeapps)
  ];

  home = {
    username = vars.username;
    homeDirectory = "/home/${vars.username}";
    stateVersion = "23.05";
    packages = with pkgs; [
      alacritty
      tmux
      starship
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
      neofetch
      spotify
    ];
    sessionVariables = {
      BROWSER = vars.programs.chrome.command;
    };
  };

  programs = {
    home-manager.enable = true;
  };
}

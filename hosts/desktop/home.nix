{ pkgs, vars, ... }:

{
  home = {
    username = vars.username;
    homeDirectory = vars.homeDir;
    packages = with pkgs; [
      gcc
      htop
      pavucontrol
      discord
      spotify
      keepassxc
      vscode.fhs
      gnome.nautilus
      jdk17
      nodejs
      ripgrep
			android-studio
    ];
    stateVersion = "24.05";
  };

  rFeatures = {
    xdg.enable = true;
    gtk.enable = true;
    i3.enable = true;
    hyprland.enable = true;
    rofi.enable = true;
    firefox.enable = true;
    alacritty.enable = true;
    zsh.enable = true;
    fzf.enable = true;
    git.enable = true;
    gh.enable = true;
    nvim.enable = true;
    tmux.enable = true;
  };

  programs.home-manager.enable = true;
}

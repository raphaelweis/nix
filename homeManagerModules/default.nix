{ rUtils, pkgs, lib, vars, ... }: {
  imports = rUtils.filesIn ./features;

  home = {
    username = vars.username;
    homeDirectory = vars.homeDir;
    packages = with pkgs; [
      gcc
      gnumake
      htop
      pavucontrol
      discord
      spotify
      keepassxc
      vscode.fhs
      gnome.nautilus
      jdk17
      nodejs
      ruby_3_3
      ripgrep
      android-studio
      google-chrome
    ];
  };

  rFeatures = {
    i3.enable = lib.mkDefault false;
    theme.enable = lib.mkDefault true;
    xdg.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    rofi.enable = lib.mkDefault true;
    firefox.enable = lib.mkDefault true;
    alacritty.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    gh.enable = lib.mkDefault true;
    nvim.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    stylix.enable = lib.mkDefault true;
  };

  programs = {
    bash.enable = true;
    home-manager.enable = true;
  };
}

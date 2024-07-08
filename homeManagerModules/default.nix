{ inputs, rUtils, pkgs, lib, vars, ... }: {
  imports = [ inputs.ags.homeManagerModules.default ]
    ++ (rUtils.filesIn ./features);

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
      lunar-client
      brave
    ];
  };

  rFeatures = {
    i3.enable = lib.mkDefault false;
    gtk.enable = lib.mkDefault true;
    xdg.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault false;
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
    dunst.enable = lib.mkDefault true;
    thunderbird.enable = lib.mkDefault true;
    ags.enable = lib.mkDefault true;
    dconf.enable = lib.mkDefault true;
  };

  programs = {
    bash.enable = true;
    home-manager.enable = true;
  };
}

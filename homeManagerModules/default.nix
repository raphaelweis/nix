{
  rUtils,
  inputs,
  pkgs,
  lib,
  vars,
  ...
}:
{
  imports = rUtils.filesIn ./features;

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    extraOptions = ''
      !include ${vars.homeDir}/.config/nix/github_token.txt
    '';
  };

  home = {
    username = vars.username;
    homeDirectory = vars.homeDir;
    packages =
      with pkgs;
      [
        pavucontrol
        spotify
        nautilus
        vscode-fhs
        ghostty
        chntpw
      ]
      ++ [ inputs.zen-browser.packages.${pkgs.system}.default ];
  };

  rFeatures = {
    i3.enable = lib.mkDefault true;
    gtk.enable = lib.mkDefault true;
    xdg.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    hyprpaper.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault true;
    rofi.enable = lib.mkDefault true;
    firefox.enable = lib.mkDefault true;
    alacritty.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    gh.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    stylix.enable = lib.mkDefault true;
    dunst.enable = lib.mkDefault true;
    thunderbird.enable = lib.mkDefault true;
    ags.enable = lib.mkDefault false;
    dconf.enable = lib.mkDefault true;
    node.enable = lib.mkDefault true;
    android.enable = lib.mkDefault false;
    nixvim.enable = lib.mkDefault true;
  };

  programs = {
    bash.enable = true;
    home-manager.enable = true;
  };
}

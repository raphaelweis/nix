{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    inputs.zen-browser.homeModules.twilight
    ./cmdline.nix
    ./nvim.nix
    ./sway.nix
    ./ghostty.nix
    ./tofi.nix
    ./tmux.nix
    ./zsh.nix
    ./git.nix
    ./gh.nix
    ./fzf.nix
    ./fonts.nix
    ./alacritty.nix
    ./i3status.nix
    ./dropbox.nix
    ./rofi.nix
    ./xdg.nix
    ./android.nix
    ./dconf.nix
    ./cursor.nix
  ];

  home = {
    packages = with pkgs; [
      discord
      spotify
      pavucontrol
      chntpw
      postman
      nautilus
    ];
  };

  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    zen-browser.enable = true;
  };

  rw = {
    cmdline.enable = lib.mkDefault true;
    nvim.enable = lib.mkDefault true;
    sway.enable = lib.mkDefault false;
    ghostty.enable = lib.mkDefault true;
    tofi.enable = lib.mkDefault false;
    tmux.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    gh.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    fonts.enable = lib.mkDefault true;
    alacritty.enable = lib.mkDefault true;
    i3status.enable = lib.mkDefault true;
    dropbox.enable = lib.mkDefault true;
    rofi.enable = lib.mkDefault true;
    xdg.enable = lib.mkDefault true;
    android.enable = lib.mkDefault true;
    dconf.enable = lib.mkDefault true;
    cursor.enable = lib.mkDefault true;
  };

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}

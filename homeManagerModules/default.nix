{
  lib,
  isWork,
  ...
}:

{
  imports = [
    ./gui-pkgs.nix
    ./cmdline-pkgs.nix
    ./nvim.nix
    ./ghostty.nix
    ./tmux.nix
    ./zsh.nix
    ./git.nix
    ./gh.nix
    ./fzf.nix
    ./fonts.nix
    ./alacritty.nix
    ./xdg.nix
    ./android.nix
    ./dconf.nix
    ./cursor.nix
    ./discord.nix
    ./gtk.nix
    ./firefox.nix
    ./starship.nix
  ];

  rw = {
    nvim.enable = lib.mkDefault true;
    ghostty.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;

    guiPkgs.enable = lib.mkDefault (!isWork);
    cmdlinePkgs.enable = lib.mkDefault (!isWork);
    git.enable = lib.mkDefault (!isWork);
    gh.enable = lib.mkDefault (!isWork);
    alacritty.enable = lib.mkDefault (!isWork);
    xdg.enable = lib.mkDefault (!isWork);
    android.enable = lib.mkDefault (!isWork);
    cursor.enable = lib.mkDefault (!isWork);
    discord.enable = lib.mkDefault (!isWork);
    dconf.enable = lib.mkDefault (!isWork);
    firefox.enable = lib.mkDefault (!isWork);
    fonts.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;

    gtk.enable = lib.mkDefault false;
  };

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}

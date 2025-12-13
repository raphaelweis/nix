{
  lib,
  inputs,
  isWork,
  ...
}:

{
  imports = [
    inputs.ags.homeManagerModules.default
    ./gui-pkgs.nix
    ./cmdline-pkgs.nix
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
    ./minecraft.nix
    ./discord.nix
    ./hyprland.nix
    ./gtk.nix
    ./ags.nix
  ];

  rw = {
    nvim.enable = lib.mkDefault true;
    ghostty.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;

    guiPkgs.enable = lib.mkDefault (!isWork);
    cmdlinePkgs.enable = lib.mkDefault (!isWork);
    sway.enable = lib.mkDefault (!isWork);
    tofi.enable = lib.mkDefault (!isWork);
    git.enable = lib.mkDefault (!isWork);
    gh.enable = lib.mkDefault (!isWork);
    fonts.enable = lib.mkDefault (!isWork);
    alacritty.enable = lib.mkDefault (!isWork);
    i3status.enable = lib.mkDefault (!isWork);
    rofi.enable = lib.mkDefault (!isWork);
    xdg.enable = lib.mkDefault (!isWork);
    android.enable = lib.mkDefault (!isWork);
    cursor.enable = lib.mkDefault (!isWork);
    minecraft.enable = lib.mkDefault (!isWork);
    discord.enable = lib.mkDefault (!isWork);
    hyprland.enable = lib.mkDefault (!isWork);
    gtk.enable = lib.mkDefault (!isWork);
    dconf.enable = lib.mkDefault (!isWork);
    ags.enable = lib.mkDefault (!isWork);

    dropbox.enable = lib.mkDefault false;
  };

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}

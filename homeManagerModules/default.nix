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
  ];

  home = {
    pointerCursor = {
      name = "macOS";
      package = pkgs.apple-cursor;
      size = 24;
    };
    packages = with pkgs; [
      discord
      spotify
      pavucontrol
      chntpw
      postman
      nautilus
    ];
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
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

  systemd.user.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = 1;
  };

  rw = {
    cmdline.enable = lib.mkDefault true;
    nvim.enable = lib.mkDefault true;
    sway.enable = lib.mkDefault true;
    ghostty.enable = lib.mkDefault true;
    tofi.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    gh.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    fonts.enable = lib.mkDefault true;
    alacritty.enable = lib.mkDefault true;
    i3status.enable = lib.mkDefault true;
    dropbox.enable = lib.mkDefault true;
  };

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}

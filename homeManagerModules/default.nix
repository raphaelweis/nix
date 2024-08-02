{ rUtils, pkgs, lib, vars, ... }: {
  imports = rUtils.filesIn ./features;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  home = {
    username = vars.username;
    homeDirectory = vars.homeDir;
    packages = with pkgs; [
      pavucontrol
      spotify
      keepassxc
      nautilus
    ];
  };

  rFeatures = {
    i3.enable = lib.mkDefault false;
    gtk.enable = lib.mkDefault true;
    xdg.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault false;
    waybar.enable = lib.mkDefault false;
    rofi.enable = lib.mkDefault true;
    firefox.enable = lib.mkDefault true;
    alacritty.enable = lib.mkDefault false;
    zsh.enable = lib.mkDefault false;
    fzf.enable = lib.mkDefault false;
    git.enable = lib.mkDefault false;
    gh.enable = lib.mkDefault false;
    # nvim.enable = lib.mkDefault false;
    tmux.enable = lib.mkDefault true;
    stylix.enable = lib.mkDefault true;
    dunst.enable = lib.mkDefault true;
    thunderbird.enable = lib.mkDefault true;
    ags.enable = lib.mkDefault true;
    dconf.enable = lib.mkDefault true;
    node.enable = lib.mkDefault true;
    android.enable = lib.mkDefault true;
  };

  programs = {
    bash.enable = false;
    neovim.enable = false;
    home-manager.enable = true;
  };
}

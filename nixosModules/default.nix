{ lib, pkgs, rUtils, ... }: {
  imports = rUtils.filesIn ./features;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [ vim steam-run gcc udisks ];

  programs = {
    zsh.enable = true;
    adb.enable = true;
    steam.enable = true;
  };
  security.polkit.enable = true;

  rFeatures = {
    gdm.enable = lib.mkDefault false;
    kde.enable = lib.mkDefault false;
    gnome.enable = lib.mkDefault false;
    i3.enable = lib.mkDefault false;
    light.enable = lib.mkDefault true;
    fonts.enable = lib.mkDefault true;
    stylix.enable = lib.mkDefault true;
    sddm.enable = lib.mkDefault false;
    libinput.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    docker.enable = lib.mkDefault true;
    virtualization.enable = lib.mkDefault true;
    boot.enable = lib.mkDefault true;
    bluetooth.enable = lib.mkDefault true;
    console.enable = lib.mkDefault true;
    locale.enable = lib.mkDefault true;
    networking.enable = lib.mkDefault true;
    pipewire.enable = lib.mkDefault true;
    user.enable = lib.mkDefault true;
    gnupg.enable = lib.mkDefault true;
  };
}

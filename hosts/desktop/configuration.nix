{ pkgs, ... }:
{
  imports = [
    (import ../../modules/nixos/bluetooth)
    (import ../../modules/nixos/boot)
    (import ../../modules/nixos/fonts)
    (import ../../modules/nixos/hyprland)
    (import ../../modules/nixos/locales)
    (import ../../modules/nixos/networking)
    (import ../../modules/nixos/nix)
    (import ../../modules/nixos/pipewire)
    (import ../../modules/nixos/security)
    (import ../../modules/nixos/services)
    (import ../../modules/nixos/user)
    (import ../../modules/nixos/xremap)
    (import ./hardware-configuration.nix)
  ];

  environment.systemPackages = with pkgs; [
    home-manager
    vim
    gcc
    alsa-utils
    killall
    ripgrep
    curl
    git
  ];

  system.stateVersion = "23.05";
}

{ pkgs, ... }:
{
  imports = [
    (import ../../features/nixos/opengl)
    (import ../../features/nixos/bluetooth)
    (import ../../features/nixos/boot)
    (import ../../features/nixos/fonts)
    (import ../../features/nixos/hyprland)
    (import ../../features/nixos/locales)
    (import ../../features/nixos/networking)
    (import ../../features/nixos/nix)
    (import ../../features/nixos/pipewire)
    (import ../../features/nixos/security)
    (import ../../features/nixos/services)
    (import ../../features/nixos/user)
    (import ../../features/nixos/xremap)
    (import ../../features/nixos/wine)
  ];

  environment.systemPackages = with pkgs; [
    home-manager
    htop
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

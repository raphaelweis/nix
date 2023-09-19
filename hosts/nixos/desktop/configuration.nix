{ inputs, pkgs, ... }:
let
  vars = import ./vars.nix;
in
{
  imports = [
    # modules
    inputs.home-manager.nixosModules.home-manager

    # features
    (import ../../../modules/nixos/bluetooth)
    (import ../../../modules/nixos/boot)
    (import ../../../modules/nixos/fonts)
    (import ../../../modules/nixos/hyprland)
    (import ../../../modules/nixos/locales)
    (import ../../../modules/nixos/networking)
    (import ../../../modules/nixos/nix)
    (import ../../../modules/nixos/pipewire)
    (import ../../../modules/nixos/security)
    (import ../../../modules/nixos/services)
    (import ../../../modules/nixos/user)
    (import ../../../modules/nixos/xremap)

    # machine specific hardware config
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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${vars.username} = import ./home.nix;
  };

  system.stateVersion = "23.05";
}

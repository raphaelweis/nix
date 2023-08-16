{ pkgs, lib, ... }:
{
    system.stateVersion = "23.05";

    imports = [./hardware-configuration.nix];
    boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        loader = {
            systemd-boot = {
                enable = true;
                configurationLimit = 3;
            };
            efi.canTouchEfiVariables = true;
            timeout = 5;
        };
    };
    hardware.bluetooth.enable = true;
}
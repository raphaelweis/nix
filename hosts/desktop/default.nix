{ pkgs, lib, hyprland, ... }:
{
    system.stateVersion = "23.05";

	imports = [
		(import ../../modules/desktop/hyprland)
		./hardware-configuration.nix
	]; 

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
	hardware.opengl.enable = true;
}

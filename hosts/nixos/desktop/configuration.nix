{ lib, pkgs, ... }:
{
	imports = [ ./hardware-configuration.nix ];

	rw.homeManagerConfig = ./home.nix;

	# Use the systemd-boot EFI boot loader.
	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
		kernelParams = [
			"amd_pstate=active" 
			"amd_pstate.shared_mem=1"
			"nohibernate"

			# https://www.phoronix.com/news/Linux-Splitlock-Hurts-Gaming
			"split_lock_detect=off"
			"acpi_sleep=nonvs"
		];
	};

	hardware = {
		cpu.amd.updateMicrocode = true;
	};

	system.stateVersion = "25.05";
}


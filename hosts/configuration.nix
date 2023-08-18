{ pkgs, user, ... }:
{
	nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Enable flakes and the nix command

	environment.pathsToLink = [ "/share/zsh" ]; # Enable completion for system packages

    users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "kvm" "libvirtd" ];
        shell = pkgs.zsh;
    };
    security.sudo.wheelNeedsPassword = false;
    time.timeZone = "Europe/Brussels";
    i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocaleSettings = {
		    LC_ADDRESS = "fr_FR.UTF-8";
            LC_IDENTIFICATION = "fr_FR.UTF-8";
            LC_MEASUREMENT = "fr_FR.UTF-8";
            LC_MONETARY = "fr_FR.UTF-8";
            LC_NAME = "fr_FR.UTF-8";
            LC_NUMERIC = "fr_FR.UTF-8";
            LC_PAPER = "fr_FR.UTF-8";
            LC_TELEPHONE = "fr_FR.UTF-8";
            LC_TIME = "fr_FR.UTF-8";
        };
    };
    console = {
        font = "Lat2-Terminus16";
        keyMap = "us-acentos";
    };
    security.rtkit.enable = true;
    security.polkit.enable = true;

    networking.networkmanager.enable = true;
	services = {
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
	    };
	    gvfs.enable = true;
    };

    fonts.packages = with pkgs; [
        font-awesome
        corefonts
        (nerdfonts.override {
            fonts = [
                "JetBrainsMono"
            ];
        })
    ];

    environment.systemPackages = with pkgs; [
        vim
        gcc
        alsa-utils
        killall
        ripgrep
        curl
    ];
    programs.zsh.enable = true;
    programs.hyprland.enable = true;
}

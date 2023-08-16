{ pkgs, user, ... }:
{
    home.stateVersion = "22.11"; # Please read the comment before changing.

    home.packages = with pkgs; [
		alacritty
		tmux
		firefox
		starship
		neovim
		rofi
		lsd
		wl-clipboard
		cliphist
		hyprpaper
		bluetuith
		pavucontrol
		vscode
		networkmanagerapplet
		acpi
    ];

    programs = {
		git = {
        	enable = true; 
        	userEmail = "raphael.weis.2003@gmail.com";
        	userName = "Raphaël Weis";
		};
		gh = {
			enable = true;
			gitCredentialHelper.enable = true;
		};
    };
    # wayland.windowManager.hyprland = {
    #     enable = true;
    #     xwayland.enable = true;
    # };
}

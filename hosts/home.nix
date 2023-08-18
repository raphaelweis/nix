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
		zsh = {
			enable = true;
			enableAutosuggestions = true;
			enableCompletion = true;
			enableVteIntegration = true;
			autocd = true;
			defaultKeymap = "viins";
			dotDir = ".config/zsh";
			historySubstringSearch.enable = true;
			syntaxHighlighting.enable = true;
			shellAliases = {
				vim = "nvim";
				bonjour = "cowsay bonjour";
				bt = "bluetuith";
				rr = "curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash && zsh";
				ls = "lsd";
				la = "ls -la";
				".2" = "../..";
				".3" = "../../..";
				".4" = "../../../..";
				".5" = "../../../../..";
			};
			initExtra = ''
				bindkey 'jk' vi-cmd-mode
				bindkey '^?' backward-delete-char

				ex () {
					if [ -f "$1" ] ; then
						case $1 in
							*.tar.bz2)   tar xjf $1   ;;
					*.tar.gz)    tar xzf $1   ;;
					*.bz2)       bunzip2 $1   ;;
					*.rar)       unrar x $1   ;;
					*.gz)        gunzip $1    ;;
					*.tar)       tar xf $1    ;;
					*.tbz2)      tar xjf $1   ;;
					*.tgz)       tar xzf $1   ;;
					*.zip)       unzip $1     ;;
					*.Z)         uncompress $1;;
					*.7z)        7z x $1      ;;
					*.deb)       ar x $1      ;;
					*.tar.xz)    tar xf $1    ;;
					*.tar.zst)   unzstd $1    ;;
					*)           echo "'$1' cannot be extracted via ex()" ;;
					esac
					else
						echo "'$1' is not a valid file"
							fi
				}
			'';
		};
		starship = {
			enable = true;
			enableZshIntegration = true;
		};
		fzf = {
			enable = true;
			enableZshIntegration = true;
		};
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

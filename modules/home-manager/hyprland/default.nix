{ pkgs, host, ... }:
let
	vars = import ../../../hosts/${host}/vars.nix;
	timeout = 10 * 60;
	mainMod =  "SUPER";
in
{
	home.packages = with pkgs; [ swayidle ];

	wayland.windowManager.hyprland = {
		enable = true;
		settings = {
			monitor = "${vars.display.monitor1}, ${vars.display.resolution}@${toString vars.display.refresh-rate}, auto, ${vars.display.scale}";
			env = "XCURSOR_SIZE = ${toString vars.theme.cursor.size}";
			exec-once = [
				"hyprctl setcursor ${vars.theme.cursor.theme} ${toString vars.theme.cursor.size}"
				"swayidle -w timeout ${toString timeout}  'swaylock -f' &"
				"waybar &"
				"hyprpaper &"
			];

			input = {
				kb_layout = "us";
				kb_variant = "intl";
				follow_mouse = 1;
				sensitivity = 0;
			};

			general = {
				gaps_in = 5;
				gaps_out = 20;
				border_size = 2;
				"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
				"col.inactive_border" = "rgba(595959aa)";
				layout = "dwindle";
			};

			decoration = {
				rounding = 5;
				blur = {
					enabled = true;
					size = 2;
					passes = 3;
				};
				drop_shadow = true;
				shadow_range = 4;
				shadow_render_power = 3;
				"col.shadow" = "rgba(1a1a1aee)";
			};

			animations = {
				enabled = "yes";
				bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
				animation = [
					"windows, 1, 7, myBezier"
					"windowsOut, 1, 7, default, popin 80%"
					"border, 1, 10, default"
					"borderangle, 1, 8, default"
					"fade, 1, 7, default"
					"workspaces, 1, 3, default"
				];
			};

			dwindle = {
				pseudotile = true;
				preserve_split = true;
			};

			master = {
				new_is_master = true;
			};

			windowrule = [
				"float, pavucontrol"
			];
			
			bind = [
				"${mainMod}, Q, exec, ${vars.programs.browser}"
				"${mainMod}, RETURN, exec, ${vars.programs.terminal} -e tmux"
				"${mainMod}, C, killactive,"
				"${mainMod} SHIFT, M, exit,"
				"${mainMod}, E, exec, ${vars.programs.file-explorer}"
				"${mainMod}, V, togglefloating,"
				"${mainMod}, M, fullscreen,"
				"${mainMod}, P, exec, rofi -show run"
				"${mainMod}, J, togglesplit, # dwindle"

				"${mainMod}, left, movefocus, l"
				"${mainMod}, right, movefocus, r"
				"${mainMod}, up, movefocus, u"
				"${mainMod}, down, movefocus, d"

				"${mainMod}, 1, workspace, 1"
				"${mainMod}, 2, workspace, 2"
				"${mainMod}, 3, workspace, 3"
				"${mainMod}, 4, workspace, 4"
				"${mainMod}, 5, workspace, 5"
				"${mainMod}, 6, workspace, 6"
				"${mainMod}, 7, workspace, 7"
				"${mainMod}, 8, workspace, 8"
				"${mainMod}, 9, workspace, 9"
				"${mainMod}, 0, workspace, 10"

				"${mainMod} SHIFT, 1, movetoworkspace, 1"
				"${mainMod} SHIFT, 2, movetoworkspace, 2"
				"${mainMod} SHIFT, 3, movetoworkspace, 3"
				"${mainMod} SHIFT, 4, movetoworkspace, 4"
				"${mainMod} SHIFT, 5, movetoworkspace, 5"
				"${mainMod} SHIFT, 6, movetoworkspace, 6"
				"${mainMod} SHIFT, 7, movetoworkspace, 7"
				"${mainMod} SHIFT, 8, movetoworkspace, 8"
				"${mainMod} SHIFT, 9, movetoworkspace, 9"
				"${mainMod} SHIFT, 0, movetoworkspace, 10"

				"${mainMod}, mouse_down, workspace, e+1"
				"${mainMod}, mouse_up, workspace, e-1"
			];

			bindm = [
				"${mainMod}, mouse:272, movewindow"
				"${mainMod}, mouse:273, resizewindow"
			];
		};	
		extraConfig = ''
	   		$mainMod = SUPER
	
		'';
	};
}

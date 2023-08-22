{ pkgs, ... }:
{
	# to make headset buttons work
	systemd.user.services.mpris-proxy = {
		Unit.Description = "Mpris proxy";
		Unit.After = [ "network.target" "sound.target" ];
		Service.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
		Install.WantedBy = [ "default.target" ];
	};

	home.packages = with pkgs; [ # desktop specific user packages
		bluetuith
	];
}

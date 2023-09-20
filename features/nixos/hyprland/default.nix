{ ... }:
{
  # Autostart Hyprland on login if on tty1
  environment = {
    loginShellInit = ''
      			if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      				exec dbus-launch Hyprland
      			fi
      		'';
  };

  security.pam.services.swaylock = { }; # required for swaylock to work
}

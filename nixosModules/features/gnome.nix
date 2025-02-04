{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.rFeatures.gnome.enable = lib.mkEnableOption "KDE nixos configuration";

  config = lib.mkIf config.rFeatures.gnome.enable {
    programs.ssh.askPassword = lib.mkForce "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";
    hardware.pulseaudio.enable = false;
    services.xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}

{ pkgs, host, ... }:
let 
	vars = import ../../../hosts/${host}/vars.nix;
in
{
    users.users.${vars.username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "kvm" "libvirtd" "input" ];
        shell = pkgs.zsh;
    };
	programs.zsh.enable = true;
	environment.pathsToLink = [ "/share/zsh" ]; # Enable completion for system packages
    security.sudo.wheelNeedsPassword = false;
}

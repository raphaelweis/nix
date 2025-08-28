{ lib, pkgs, ... }:
{
  options.rw = {
    virtualization.enable = lib.mkEnableOption "Virtualization software like qemu, virtualbox...";
  };
  config = {
    environment.systemPackages = with pkgs; [
      qemu
      gnome-boxes
    ];
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
  };
}

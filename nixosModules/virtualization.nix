{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.rw = {
    virtualization.enable = lib.mkEnableOption "Virtualization software like qemu, virtualbox...";
  };
  config = lib.mkIf config.rw.virtualization.enable {
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

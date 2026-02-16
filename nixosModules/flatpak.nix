{ lib, config, ... }:
{
  options.rw.flatpak = {
    enable = lib.mkEnableOption "Flatpak and flathub via nix-flatpak";
  };
  config = lib.mkIf config.rw.flatpak.enable {
    services.flatpak = {
      enable = true;
      packages = [
        "org.pgadmin.pgadmin4"
      ];
    };
  };
}

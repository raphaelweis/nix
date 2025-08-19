{ lib, pkgs, ... }:
{
  options.rw = {
    minecraft.enable = lib.mkEnableOption "Minecraft installation and configuration, through the modrinth-app client.";
  };
  config = {
    # When launching modrinth for the first time, it will try to install java 21 on it's own. If it's fails, go to settings and point it to the nixpkgs java 21 installation.
    home.packages = with pkgs; [
      modrinth-app
      jdk21
    ];
  };
}

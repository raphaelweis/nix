{ lib, pkgs, ... }:
{
  options.rw = {
    discord.enable = lib.mkEnableOption "discord configuration (with krisp patch).";
  };
  config =
    let
      # Patch script to make krisp audio work.
      # Run: krisp-patcher ~/.config/discord/<discord-version>/modules/discord_krisp/discord_krisp.node
      # Don't forget to into discord settings and enable krisp audio afterwards.
      krisp-patcher =
        pkgs.writers.writePython3Bin "krisp-patcher"
          {
            libraries = with pkgs.python3Packages; [
              capstone
              pyelftools
            ];
            flakeIgnore = [
              "E501" # line too long (82 > 79 characters)
              "F403" # 'from module import *' used; unable to detect undefined names
              "F405" # name may be undefined, or defined from star imports: module
            ];
          }
          (
            builtins.readFile (
              pkgs.fetchurl {
                url = "https://pastebin.com/raw/8tQDsMVd";
                sha256 = "sha256-IdXv0MfRG1/1pAAwHLS2+1NESFEz2uXrbSdvU9OvdJ8=";
              }
            )
          );
    in
    {
      home.packages = [
        krisp-patcher
        pkgs.discord
      ];
    };
}

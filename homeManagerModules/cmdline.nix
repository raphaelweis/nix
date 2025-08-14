{ pkgs, lib, ... }:
{
  options.rw = {
    cmdline.enable = lib.mkEnableOption "common cmdline tools and utilities";
  };
  config = {
    home.packages = with pkgs; [
      xclip
      ripgrep
      fd
      gcc
      nodejs
      rlwrap
    ];
  };
}

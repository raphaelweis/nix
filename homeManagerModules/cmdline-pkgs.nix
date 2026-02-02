{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.rw = {
    cmdlinePkgs.enable = lib.mkEnableOption "common cmdline tools and utilities";
  };
  config = lib.mkIf config.rw.cmdlinePkgs.enable {
    home.packages = with pkgs; [
      xclip
      ripgrep
      fd
      gcc
      nodejs
      pnpm
      rlwrap
      chntpw
      acpi
      google-cloud-sdk
      sops
      age
      typst
      file
      jq
    ];

    programs = {
      nix-index = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}

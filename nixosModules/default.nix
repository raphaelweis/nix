{ inputs, lib, pkgs, rUtils, ... }: {
  imports = [ inputs.home-manager.nixosModules.home-manager ]
    ++ (rUtils.filesIn ./features);

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config = {
    android_sdk.accept_license = true;
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [ vim steam-run ];

  programs = {
    zsh.enable = true;
    adb.enable = true;
    steam.enable = true;
  };
  services = { onedrive.enable = true; };

  rFeatures = {
    gdm.enable = lib.mkDefault false;
    kde.enable = lib.mkDefault false;
    gnome.enable = lib.mkDefault false;
    i3.enable = lib.mkDefault false;
    light.enable = lib.mkDefault false;
    sddm.enable = lib.mkDefault true;
    fonts.enable = lib.mkDefault true;
    libinput.enable = lib.mkDefault true;
    hyperland.enable = lib.mkDefault true;
    docker.enable = lib.mkDefault true;
    virtualization.enable = lib.mkDefault true;
    boot.enable = lib.mkDefault true;
    bluetooth.enable = lib.mkDefault true;
    console.enable = lib.mkDefault true;
    locale.enable = lib.mkDefault true;
    networking.enable = lib.mkDefault true;
    pipewire.enable = lib.mkDefault true;
    user.enable = lib.mkDefault true;
  };
}

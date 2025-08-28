{
  inputs,
  config,
  lib,
  pkgs,
  username,
  system,
  ...
}:
{
  imports = [
    ./boot.nix
    ./gnome.nix
    ./networking.nix
    ./steam.nix
    ./docker.nix
    ./virtualization.nix
  ];

  options.rw.homeManagerConfig = lib.mkOption {
    description = "Home manager config path for host specific settings.";
    type = lib.types.path;
  };

  config = {
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      users.${username}.imports = [
        (import config.rw.homeManagerConfig)
        inputs.self.outputs.homeManagerModules.default
      ];
      extraSpecialArgs = { inherit inputs username system; };
    };

    time.timeZone = "Europe/Paris";

    i18n.defaultLocale = "en_US.UTF-8";

    services = {
      xserver.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      gvfs.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      libinput.enable = true;
    };

    security = {
      polkit.enable = true;
      rtkit.enable = true;
    };

    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
    };

    powerManagement = {
      enable = true;
    };

    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "input"
        "video"
        "kvm"
        "adbusers"
        "docker"
        "libvirtd"
      ];
      shell = pkgs.zsh;
    };

    programs = {
      firefox.enable = true;
      zsh.enable = true;
      geary.enable = false;
      sway.enable = false;
      adb.enable = true;
    };

    environment.systemPackages = with pkgs; [
      vim
      killall
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    rw = {
      boot.enable = lib.mkDefault true;
      gnome.enable = lib.mkDefault true;
      networking.enable = lib.mkDefault true;
      steam.enable = lib.mkDefault true;
      docker.enable = lib.mkDefault true;
      virtualization.enable = lib.mkDefault true;
    };
  };
}

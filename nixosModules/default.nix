{
  inputs,
  config,
  lib,
  pkgs,
  username,
  isWork,
  system,
  theme,
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
    ./postgresql.nix
    ./sops.nix
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
      backupFileExtension = "bak";
      extraSpecialArgs = {
        inherit
          inputs
          username
          isWork
          system
          theme
          ;
      };
    };

    time.timeZone = "Europe/Paris";

    i18n.defaultLocale = "en_US.UTF-8";

    services = {
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

    i18n.inputMethod = {
      enable = true;
      type = "ibus";
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
      zsh.enable = true;
      geary.enable = false;
      sway.enable = false;
      nix-ld.enable = true;
      gnupg.agent.enable = true;
    };

    qt.enable = true;

    environment.systemPackages = with pkgs; [
      vim
      killall
      home-manager
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    rw = {
      boot.enable = lib.mkDefault true;
      networking.enable = lib.mkDefault true;
      steam.enable = lib.mkDefault true;
      docker.enable = lib.mkDefault true;
      virtualization.enable = lib.mkDefault true;
      gnome.enable = lib.mkDefault true;
      postgresql.enable = lib.mkDefault true;
      sops.enable = lib.mkDefault true;
    };
  };
}

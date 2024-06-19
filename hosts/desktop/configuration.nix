{ config, lib, pkgs, inputs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  users.users."raphaelw" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  hmConfig = ./home.nix;

  rFeatures = {
    i3.enable = true;
    stylix.enable = true;
  };

  environment.systemPackages = with pkgs; [ vim ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
      timeout = 10;
    };
  };

  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  programs.zsh.enable = true;
  services = {
    onedrive.enable = true;
    xserver = {
      xkb.layout = "us";
      xkb.variant = "intl";
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  system.stateVersion = "24.05";
}

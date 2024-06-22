{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  users.users."raphaelw" = {
    isNormalUser = true;
    extraGroups = [ "wheel" "kvm" "adbusers" "networkmanager" ];
    shell = pkgs.zsh;
  };

  hmConfig = ./home.nix;

  rFeatures = {
    gdm.enable = true;
    fonts.enable = true;
    i3.enable = true;
    hyperland.enable = true;
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

  programs = {
    zsh.enable = true;
    adb.enable = true;
  };
  services = {
    onedrive.enable = true;
    xserver = {
      xkb.layout = "us";
      xkb.variant = "intl";
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth = {
      enable = true;
      package = pkgs.bluez;
      powerOnBoot = true;
      settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
    };
  };

  system.stateVersion = "24.05";
}

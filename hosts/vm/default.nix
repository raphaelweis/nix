{ pkgs, inputs, ... }:
let
  vars = {
    hostname = "nixos-vm";
    username = "raphaelw";
    programs = {
      neovim = {
        name = "neovim";
        command = "nvim";
      };
      chrome = {
        name = "google-chrome";
        command = "google-chrome-stable";
      };
      alacritty = {
        name = "alacritty";
        command = "alacritty -e tmux";
        font-size = 12;
        opacity = 0.7;
      };
      nautilus = {
        name = "nautilus";
        command = "nautilus";
      };
      rofi = {
        name = "rofi";
        command = "rofi -show drun";
        package = pkgs.rofi-wayland;
      };
      swaylock = {
        name = "swaylock";
        command = "swaylock -f";
      };
    };
    display = {
      vm = "Hyprland";
      refresh-rate = 60;
      resolution = "1920x1080";
      monitor1 = "";
      scale = "1";
    };
    theme = {
      gtk-theme = "Gruvbox-Dark-B-LB";
      icon-theme = "Papirus-Dark";
      cursor = {
        theme = "Bibata-Modern-Ice";
        package = "bibata-cursors";
        size = 20;
      };
    };
    fonts = {
      system-font = "JetBrainsMonoNL NF";
    };
  };
in
inputs.nixpkgs.lib.nixosSystem {
  modules = [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit pkgs inputs vars; };
        users.${vars.username} = import ./home.nix;
      };
    }
    (import ./configuration.nix)
    (import ./hardware-configuration.nix)
  ];
  specialArgs = { inherit pkgs inputs vars; };
}

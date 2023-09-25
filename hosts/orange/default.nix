{ pkgs, inputs }:
let
  vars = {
    username = "vxsw5537";
    programs = {
      neovim = {
        name = "nvim";
        command = "nvim";
      };
      chromium = {
        name = "chromium";
        command = "chromium-browser";
      };
      alacritty = {
        name = "alacritty";
        command = "gnome-terminal"; # we use nixGL because this is a non nixos distro
        font-size = 12;
        opacity = 0.9;
      };
    };
    fonts = {
      system-font = "JetBrainsMonoNL NF";
    };
  };
in
inputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = [ ./home.nix ];
  extraSpecialArgs = { inherit pkgs inputs vars; };
}

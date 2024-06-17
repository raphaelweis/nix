{ lib, config, inputs, rUtils, ... }: {
  options = {
    username = lib.mkOption {
      default = "raphaelw";
      description = "Username";
    };
    hmConfig = lib.mkOption {
      description = "Home manager config path";
      type = lib.types.path;
    };
  };

  config = {
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      extraSpecialArgs = { inherit inputs rUtils; };
      users = {
        "raphaelw" = {
          imports = [
            (import config.hmConfig)
            inputs.nixvim.homeManagerModules.nixvim
            inputs.self.outputs.homeManagerModules.default
          ];
        };
      };
    };
  };
}

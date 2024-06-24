{ lib, config, inputs, vars, rUtils, ... }: {
  options.hmConfig = lib.mkOption {
    description = "Home manager config path";
    type = lib.types.path;
  };

  config = {
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      extraSpecialArgs = { inherit inputs rUtils vars; };
      users = {
        ${vars.username} = {
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

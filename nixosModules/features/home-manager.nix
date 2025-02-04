{
  lib,
  config,
  inputs,
  vars,
  pkgs,
  rUtils,
  ...
}:
{
  options.hmConfig = lib.mkOption {
    description = "Home manager config path";
    type = lib.types.path;
  };

  config = {
    environment.systemPackages = with pkgs; [ home-manager ];
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "bak";
      extraSpecialArgs = { inherit inputs rUtils vars; };
      users = {
        ${vars.username} = {
          imports = [
            (import config.hmConfig)
            inputs.self.outputs.homeManagerModules.default
            inputs.nixvim.homeManagerModules.nixvim
            inputs.ags.homeManagerModules.default
          ];
        };
      };
    };
  };
}

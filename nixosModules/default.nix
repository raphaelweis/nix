{ inputs, rUtils, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
  ] ++ (rUtils.filesIn ./features);
}

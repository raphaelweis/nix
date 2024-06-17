{ inputs, rUtils, ... }: {
  imports = [ inputs.home-manager.nixosModules.home-manager ]
    ++ (rUtils.filesIn ./features);
}
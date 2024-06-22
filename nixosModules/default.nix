{ inputs, rUtils, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config = {
    android_sdk.accept_license = true;
    allowUnfree = true;
  };

  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
  ] ++ (rUtils.filesIn ./features);
}

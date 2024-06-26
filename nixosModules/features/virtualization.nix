{ lib, config, vars, ... }: {
  options.rFeatures = {
    virtualization.enable =
      lib.mkEnableOption "Enables and configures virtualization with virt-manager";
  };

  config = lib.mkIf config.rFeatures.virtualization.enable {
    users.users.${vars.username}.extraGroups = [ "libvirtd" ];
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}

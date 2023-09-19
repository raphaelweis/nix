{ host, inputs, ... }:
let
  vars = import ../../../hosts/${host}/vars.nix;
in
{
  imports = [
    inputs.xremap.nixosModules.default
  ];
  hardware.uinput.enable = true;
  services.xremap = {
    userName = vars.username;
    config = {
      keymap = [
        # vim style navigation
        {
          name = "Go Left";
          remap = {
            "ALT-h" = "left";
          };
        }
        {
          name = "Go Down";
          remap = {
            "ALT-j" = "down";
          };
        }
        {
          name = "Go Up";
          remap = {
            "ALT-k" = "up";
          };
        }
        {
          name = "Go Right";
          remap = {
            "ALT-l" = "right";
          };
        }
      ];
    };
  };
}

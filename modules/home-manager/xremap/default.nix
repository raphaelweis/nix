{ inputs, ... }:
{
  imports = [
    inputs.xremap.homeManagerModules.default
  ];
  services.xremap = {
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

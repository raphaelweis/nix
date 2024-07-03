{ lib, config, ... }: {
  options.rFeatures.thunderbird.enable =
    lib.mkEnableOption "Thunderbird (email client)";

  config = lib.mkIf config.rFeatures.thunderbird.enable {
    programs.thunderbird = {
      enable = true;
      profiles.default.isDefault = true;
      settings."mailnews.default_sort_order" = 2;
    };
  };
}

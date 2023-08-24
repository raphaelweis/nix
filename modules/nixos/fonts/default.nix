{ pkgs, ... }:
{
    console = {
        font = "Lat2-Terminus16";
        keyMap = "us-acentos";
    };

    fonts.packages = with pkgs; [
		dejavu_fonts
        font-awesome
        corefonts
        (nerdfonts.override {
            fonts = [
                "JetBrainsMono"
            ];
        })
    ];
}

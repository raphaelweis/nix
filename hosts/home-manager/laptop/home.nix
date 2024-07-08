{ ... }: {
  rFeatures = {
    tmux.withBattery = true;
    rofi.width = 50;
    alacritty = {
      fontSize = 10;
      winitX11ScaleFactor = 2;
    };
    hyprland = {
      enable = false;
      gdkScale = 2;
      isOnNixos = false;
    };
  };

  home.stateVersion = "24.05";
}

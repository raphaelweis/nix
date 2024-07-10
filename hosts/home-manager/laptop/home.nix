{ ... }: {
  rFeatures = {
    tmux.withBattery = true;
    rofi.width = 50;
    android.enable = false;
    firefox.enable = false;
    xdg.enableMimeApps = false;
    alacritty = {
      fontSize = 10;
      winitX11ScaleFactor = 2;
    };
    hyprland = {
      enable = true;
      gdkScale = 2;
      isOnNixos = false;
    };
  };

  home.stateVersion = "24.05";
}

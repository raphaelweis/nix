{ ... }: {
  rFeatures = {
    tmux.withBattery = true;
    rofi.width = 50;
    # nvim.enable = false;
    android.enable = false;
    firefox.enable = true;
    xdg.enableMimeApps = true;
    alacritty = {
      fontSize = 10;
      winitX11ScaleFactor = 2;
    };
    hyprland = {
      enable = true;
      gdkScale = 2;
      isOnNixos = true;
    };
  };

  home.stateVersion = "24.05";
}

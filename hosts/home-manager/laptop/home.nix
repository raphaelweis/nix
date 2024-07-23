{ ... }: {
  rFeatures = {
    tmux.withBattery = true;
    rofi.width = 50;
    # nvim.enable = false;
    android.enable = false;
    firefox.enable = false;
    xdg.enableMimeApps = false;
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

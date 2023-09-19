{
  username = "vxsw5537";
  programs = {
    editor = {
      name = "nvim";
      command = "nvim";
    };
    terminal = {
      name = "alacritty";
      command = "alacritty -e tmux";
      font-size = 12;
      opacity = 0.9;
    };
  };
  fonts = {
    system-font = "JetBrainsMonoNL NF";
  };
}

{
  username = "vxsw5537";
  programs = {
    editor = {
      name = "nvim";
      command = "nvim";
    };
    terminal = {
      name = "alacritty";
      command = "nixGL alacritty -e tmux"; # we use nixGL because this is a non nixos distro
      font-size = 12;
      opacity = 0.9;
    };
  };
  fonts = {
    system-font = "JetBrainsMonoNL NF";
  };
}

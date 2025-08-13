{ pkgs, lib, ... }:
{
  options.rw = {
    devenv.enable = lib.mkEnableOption "configuration for a command line dev environment. This includes shell config, tmux config, cli tools and development tools, but not editor configuration. No graphical tools should be included here.";
  };
  config = {
    home.packages = with pkgs; [
      xclip
      ripgrep
      fd
      gcc
      nodejs
      rlwrap
    ];
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      enableCompletion = true;
      defaultKeymap = "emacs";
      initContent =
        lib.mkOrder 500 # bash
          ''
            autoload -U colors && colors
            PS1="%{$fg[yellow]%}%~%{$fg[red]%} %{$reset_color%}$%b "

            alias ta="tmux attach"
            alias la="ls -la"
          '';
    };

    programs.git = {
      enable = true;
      userEmail = "raphael.weis.g@gmail.com";
      userName = "Raphaël Weis";
      extraConfig = {
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

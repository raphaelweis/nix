{ lib, ... }:
{
  options.rw = {
    zsh.enable = lib.mkEnableOption "zsh configuration.";
  };
  config = {
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
  };
}

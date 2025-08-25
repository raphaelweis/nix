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
        lib.mkOrder 1500 # bash
          ''
            autoload -U colors && colors
            PS1="%{$fg[yellow]%}%~%{$fg[red]%} %{$reset_color%}$%b "

            alias ta="tmux attach"
            alias la="ls -la"

            # Assign Alt+S to run the tmux-sessionizer script defined in [tmux.nix]
            bindkey -s '^[s' 'tmux-sessionizer\n'
          '';
    };
  };
}

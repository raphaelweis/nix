{ lib, config, ... }:
{
  options.rw.zsh = {
    enable = lib.mkEnableOption "zsh configuration.";
    extraInit = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Extra zsh config to append to at the top";
    };
  };
  config = lib.mkIf config.rw.zsh.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      enableCompletion = true;
      defaultKeymap = "emacs";
      initContent = lib.mkMerge [
        (lib.mkOrder 1500 # bash
          ''
            autoload -U colors && colors
            PS1="%{$fg[yellow]%}%~%{$fg[red]%} %{$reset_color%}$%b "

            alias ta="tmux attach"
            alias la="ls -la"

            # Assign Alt+S to run the tmux-sessionizer script defined in [tmux.nix]
            bindkey -s '^[s' 'tmux-sessionizer\n'
          ''
        )
        (lib.mkOrder 1600 config.rw.zsh.extraInit)
      ];
    };
  };
}

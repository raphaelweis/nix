{
  lib,
  config,
  ...
}:
{
  options.rw.zsh = {
    enable = lib.mkEnableOption "zsh configuration.";
    extraInit = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Extra zsh config to append to at the bottom";
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
            alias ta="tmux attach"
            alias ts="tmux-sessionizer"
            alias la="ls -la"

            export EDITOR="nvim"

            setopt PROMPT_SUBST
            PROMPT='%F{yellow}%~%f $ '
          ''
        )
        (lib.mkOrder 1600 config.rw.zsh.extraInit)
      ];
    };
  };
}

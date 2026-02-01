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
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
      };
      initContent = lib.mkMerge [
        (lib.mkOrder 1500 # bash
          ''
            alias ta="tmux attach"
            alias ts="tmux-sessionizer"
            alias la="ls -la"

            export EDITOR="zeditor --wait"

            # I know it's bad but should be temporary until I learn shell.nix
            export NVM_DIR="$HOME/.nvm"
            [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
            [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

            autoload -U add-zsh-hook

            load-nvmrc() {
              local nvmrc_path
              nvmrc_path="$(nvm_find_nvmrc)"

              if [ -n "$nvmrc_path" ]; then
                local nvmrc_node_version
                nvmrc_node_version=$(nvm version "$(cat "''${nvmrc_path}")")

                if [ "$nvmrc_node_version" = "N/A" ]; then
                  nvm install
                elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
                  nvm use
                fi
              elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
                echo "Reverting to nvm default version"
                nvm use default
              fi
            }

            add-zsh-hook chpwd load-nvmrc
            load-nvmrc
          ''
        )
        (lib.mkOrder 1600 config.rw.zsh.extraInit)
      ];
    };
  };
}

{ lib, config, pkgs, ... }: {
  options.rFeatures.nixvim.enable =
    lib.mkEnableOption "NixVim (Neovim configuration framework)";

  config = lib.mkIf config.rFeatures.nixvim.enable {
    home.packages = with pkgs; [ ripgrep ];
    programs.nixvim = {
      enable = true;
      globals = {
        mapleader = " ";
        loaded_node_provider = 0;
        loaded_perl_provider = 0;
        loaded_python3_provider = 0;
        loaded_ruby_provider = 0;
      };
      opts = {
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        number = true;
        relativenumber = true;
        colorcolumn = "80";
        signcolumn = "yes";
        splitright = true;
        splitbelow = true;
        undofile = true;
        ignorecase = true;
        smartcase = true;
        showmode = false;
        breakindent = true;
        inccommand = "split";
        scrolloff = 5;
        termguicolors = true;
        clipboard = "unnamedplus";
      };
      keymaps = [
        {
          mode = "n";
          key = "<ESC>";
          action = "<CMD>nohlsearch<CR>";
        }
      ];
      colorscheme = "gruvbox";
      colorschemes.gruvbox = {
        enable = true;
        settings = {
          contrast = "hard";
        };
      };
      plugins = {
        telescope = {
          enable = true;
          extensions = {
            fzf-native.enable = true;
            ui-select.enable = true;
          };
          keymaps = {
            "<leader>sf" = "find_files";
            "<leader>sh" = "help_tags";
            "<leader>sg" = "live_grep";
          };
        };
        mini = {
          enable = true;
          mockDevIcons = true;
          modules = {
            comment = {};
            pairs = {};
            surround = {};
            icons = {};
          };
        };
      };
    };
  };
                            }

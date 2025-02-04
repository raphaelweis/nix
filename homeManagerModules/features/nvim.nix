{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.rFeatures.nixvim.enable = lib.mkEnableOption "NixVim (Neovim configuration framework)";

  config = lib.mkIf config.rFeatures.nixvim.enable {
    home.packages = with pkgs; [
      # External tools
      ripgrep

      # Formatters
      nixfmt-rfc-style
    ];
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
            comment = { };
            pairs = { };
            surround = { };
            icons = { };
          };
        };
        lualine = {
          enable = true;
        };
        smart-splits = {
          enable = true;
          autoLoad = true;
        };
        conform-nvim = {
          enable = true;
          settings = {
            formatters_by_ft = {
              nix = [ "nixfmt" ];
            };
          };
        };
        fugitive = {
          enable = true;
        };
        harpoon = {
          enable = true;
          keymaps = {
            addFile = "<leader>a";
            toggleQuickMenu = "<leader>yf";
            navFile = {
              "1" = "<leader>u";
              "2" = "<leader>i";
              "3" = "<leader>o";
              "4" = "<leader>p";
            };
          };
        };
      };
      keymaps = [
        {
          mode = "n";
          key = "<ESC>";
          action = "<CMD>nohlsearch<CR>";
        }
        {
          mode = "n";
          key = "j";
          action = "v:count == 0 ? 'gj' : 'j'";
          options = {
            expr = true;
            silent = true;
          };
        }
        {
          mode = "n";
          key = "k";
          action = "v:count == 0 ? 'gk' : 'k'";
          options = {
            expr = true;
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<C-h>";
          action = "<CMD>lua require('smart-splits').move_cursor_left()<CR>";
        }
        {
          mode = "n";
          key = "<C-j>";
          action = "<CMD>lua require('smart-splits').move_cursor_down()<CR>";
        }
        {
          mode = "n";
          key = "<C-k>";
          action = "<CMD>lua require('smart-splits').move_cursor_up()<CR>";
        }
        {
          mode = "n";
          key = "<C-l>";
          action = "<CMD>lua require('smart-splits').move_cursor_right()<CR>";
        }
        {
          mode = "n";
          key = "<leader>fm";
          action = "<CMD>lua require('conform').format()<CR>";
        }
        {
          mode = "n";
          key = "<leader>;";
          action = "<CMD>tab Git<CR>";
        }
      ];
    };
  };
}

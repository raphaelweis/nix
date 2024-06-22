{ lib, config, ... }: {
  options.rFeatures = {
    nvim.enable = lib.mkEnableOption "enables and configures neovim";
  };

  config = lib.mkIf config.rFeatures.nvim.enable {
    programs.nixvim = {
      enable = true;
      vimAlias = true;
      defaultEditor = true;

      colorschemes.gruvbox = {
        enable = true;
        settings = {
          contrast = "hard";
          italic = {
            strings = false;
            emphasis = false;
            operators = false;
            folds = false;
          };
        };
      };
      colorscheme = "gruvbox";
      globals.mapleader = " ";
      clipboard = {
        providers.xclip.enable = true;
        register = "unnamedplus";
      };
      opts = {
        tabstop = 2;
        shiftwidth = 2;
        number = true;
        relativenumber = true;
        colorcolumn = "80";
      };
      plugins = {
        nvim-autopairs.enable = true;
        fugitive.enable = true;
        surround.enable = true;
        lualine.enable = true;
        treesitter.enable = true;
        telescope = {
          enable = true;
          keymaps = {
            "<leader>ff".action = "find_files";
            "<leader>fw".action = "grep_string";
            "<leader>fs".action = "live_grep";
            "<leader>gc".action = "git_branches";
            "<leader>gs".action = "git_branches";
          };
        };
        lsp = {
          enable = true;
          inlayHints = true;
          servers = { nixd.enable = true; };
        };
        conform-nvim = {
          enable = true;
          formattersByFt = {
            nix = [ "nixfmt" ];
            javascript = [ "prettier" ];
            json = [ "prettier" ];
            typescript = [ "prettier" ];
          };
        };
        nvim-tree = {
          enable = true;
          disableNetrw = true;
        };
      };
      keymaps = [
        {
          key = "j";
          action = "v:count == 0 ? 'gj' : 'j'";
          options = {
            expr = true;
            silent = true;
          };
        }
        {
          key = "k";
          action = "v:count == 0 ? 'gk' : 'k'";
          options = {
            expr = true;
            silent = true;
          };
        }
        {
          key = "<C-S-i>";
          action = "<CMD>lua require('conform').format()<CR>";
        }
        {
          key = "<leader>e";
          action = "<CMD>NvimTreeToggle<CR>";
        }
      ];
    };
  };
}

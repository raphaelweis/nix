{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    nvim.enable = lib.mkEnableOption "enables and configures neovim";
  };

  config = lib.mkIf config.rFeatures.nvim.enable {
    home.packages = with pkgs; [ nixfmt-classic prettierd ];
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
        luasnip.enable = true;
        friendly-snippets.enable = true;
        telescope = {
          enable = true;
          keymaps = {
            "<leader>ff".action = "find_files";
            "<leader>fw".action = "grep_string";
            "<leader>fs".action = "live_grep";
            "<leader>gc".action = "git_branches";
            "<leader>gs".action = "git_branches";
          };
          settings.defaults.mappings = {
            i = {
              "<C-j>".__raw =
                "require('telescope.actions').move_selection_next";
              "<C-k>".__raw =
                "require('telescope.actions').move_selection_previous";
            };
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
            javascriptreact = [ "prettier" ];
            typescript = [ "prettier" ];
            typescriptreact = [ "prettier" ];
            css = [ "prettier" ];
            html = [ "prettier" ];
            json = [ "prettier" ];
            jsonc = [ "prettier" ];
            yaml = [ "prettier" ];
            markdown = [ "prettier" ];
          };
        };
        nvim-tree = {
          enable = true;
          disableNetrw = true;
        };
        cmp = {
          enable = true;
          settings = {
            sources = [
              { name = "nvim_lsp"; }
              { name = "luasnip"; }
              { name = "path"; }
              { name = "buffer"; }
            ];
            mapping = {
              "<C-space>" = "cmp.mapping.complete()";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-u>" = "cmp.mapping.scroll_docs(4)";
              "<C-y>" = "cmp.mapping.confirm({ select = true })";
              "<C-j>" =
                "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<C-k>" =
                "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            };
          };
        };
      };
      keymaps = [
        {
          key = "<C-j>";
          mode = "c";
          action = "<C-n>";
        }
        {
          key = "<C-k>";
          mode = "c";
          action = "<C-p>";
        }
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

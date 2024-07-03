{ lib, config, pkgs, ... }: {
  options.rFeatures = {
    nvim.enable = lib.mkEnableOption "enables and configures neovim";
  };

  config = lib.mkIf config.rFeatures.nvim.enable {
    home.packages = with pkgs; [
      gcc
      nixfmt-classic
      nodePackages.prettier
      black
      clang-tools
      fd
    ];
    programs.nixvim = {
      enable = true;
      vimAlias = true;
      defaultEditor = true;
      withRuby = false;

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
          transparent_mode = true;
        };
      };
      colorscheme = "gruvbox";
      globals.mapleader = " ";
      clipboard = {
        providers = {
          xclip.enable = true;
          wl-copy.enable = true;
        };
        register = "unnamedplus";
      };
      opts = {
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        number = true;
        relativenumber = true;
        colorcolumn = "80";
        signcolumn = "yes";
        hlsearch = false;
      };
      plugins = {
        nvim-autopairs.enable = true;
        fugitive.enable = true;
        surround.enable = true;
        lualine.enable = true;
        treesitter.enable = true;
        ts-autotag.enable = true;
        luasnip.enable = true;
        friendly-snippets.enable = true;
        gitsigns.enable = true;
        tmux-navigator.enable = true;
        dressing = {
          enable = true;
          settings.select = {
            backend = [ "builtin" "telescope" "fzf_lua" "fzf" "nui" ];
            builtin = {
              relative = "cursor";
              override = # lua
                ''
                  function(conf)
                    conf.anchor = "NW"
                    conf.row = 1
                  end
                '';
            };
          };
        };
        telescope = {
          enable = true;
          keymaps = {
            "<leader>ff".action = "find_files";
            "<leader>fw".action = "grep_string";
            "<leader>fs".action = "live_grep";
            "<leader>gc".action = "git_branches";
            "<leader>gs".action = "git_branches";
            "<leader>tca".action = "git_branches";
          };
          settings.defaults.mappings = {
            i = {
              "<C-j>".__raw =
                "require('telescope.actions').move_selection_next";
              "<C-k>".__raw =
                "require('telescope.actions').move_selection_previous";
            };
          };
          extensions.fzf-native.enable = true;
        };
        lsp = {
          enable = true;
          keymaps = {
            diagnostic = {
              "<F2>" = "goto_next";
              "<F14>" = "goto_prev";
            };
            lspBuf = {
              "<leader>K" = "hover";
              "<leader>gr" = "references";
              "<leader>gd" = "definition";
              "<leader>gi" = "implementation";
              "<leader>gt" = "type_definition";
              "<leader>ca" = "code_action";
              "<leader>rn" = "rename";
            };
          };
          servers = {
            nixd.enable = true;
            tsserver.enable = true;
            html.enable = true;
            cssls.enable = true;
            jsonls.enable = true;
            yamlls.enable = true;
            eslint.enable = true;
            pyright.enable = true;
            dockerls.enable = true;
            docker-compose-language-service.enable = true;
            clangd.enable = true;
          };
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
            python = [ "black" ];
            c = [ "clang-format" ];
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
          key = "<leader>fm";
          action = "<CMD>lua require('conform').format()<CR>";
        }
        {
          key = "<leader>e";
          action = "<CMD>NvimTreeToggle<CR>";
        }
        {
          key = "<leader>;";
          action = "<CMD>tab Git<CR>";
        }
        {
          key = "<leader>sv";
          action = "<CMD>vsplit<CR>";
        }
        {
          key = "<leader>sh";
          action = "<CMD>split<CR>";
        }
        {
          key = "<ESC>";
          mode = "n";
          action = "<CMD>nohlsearch<CR>";
        }
      ];
    };
  };
}

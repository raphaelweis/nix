{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
{
  options.rFeatures.nixvim.enable = lib.mkEnableOption "NixVim (Neovim configuration framework)";

  config = lib.mkIf config.rFeatures.nixvim.enable {
    home.packages = with pkgs; [
      # External tools
      ripgrep
      tree-sitter

      # Formatters
      nixfmt-rfc-style
    ];
    programs.nixvim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
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
      diagnostics = {
        virtual_text = true;
      };
      colorscheme = "gruvbox";
      # colorscheme = "catppuccin";
      colorschemes = {
        gruvbox = {
          enable = true;
          lazyLoad.enable = false;
          settings = {
            contrast = "hard";
          };
        };
        catppuccin = {
          enable = true;
          settings = {
            flavour = "mocha";
          };
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
            files = { };
          };
        };
        lualine = {
          enable = true;
          luaConfig = {
            post = ''
              vim.api.nvim_set_hl(0, "StatusLine", { reverse = false })
            '';
          };
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
        treesitter = {
          enable = true;
          settings = {
            highlight = {
              enable = true;
            };
            indent = {
              enable = true;
            };
          };
        };
        lsp = {
          enable = true;
          servers = {
            nixd.enable = true;
          };
          keymaps = {
            diagnostic = {
              "<leader>dn" = "goto_next";
              "<leader>dp" = "goto_prev";
            };
            lspBuf = {
              "<leader>rn" = "rename";
              "<leader>ca" = "code_action";
              "gd" = "definition";
              "gD" = "declaration";
              "gi" = "implementation";
              "gt" = "type_definition";
              "K" = "hover";
            };
          };
        };
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            sources = [
              { name = "nvim_lsp"; }
              { name = "path"; }
              { name = "buffer"; }
              { name = "luasnip"; }
            ];
            mapping = {
              __raw = ''
                cmp.mapping.preset.insert({
                  ["<C-n>"] = cmp.mapping.select_next_item(),
                  ["<C-p>"] = cmp.mapping.select_prev_item(),
                  ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                  ["<C-f>"] = cmp.mapping.scroll_docs(4),
                  ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                  ["<C-Space>"] = cmp.mapping.complete({}),
                  ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                      luasnip.expand_or_jump()
                    end
                  end, { "i", "s" }),
                  ["<C-h>"] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                      luasnip.jump(-1)
                    end
                  end, { "i", "s" }),
                })
              '';
            };
            snippet = {
              expand = "function(args) require('luasnip').lsp_expand(args.body) end";
            };
          };
        };
        luasnip = {
          enable = true;
        };
        friendly-snippets = {
          enable = true;
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
        {
          mode = "n";
          key = "<leader>td";
          action.__raw = ''
            function() 
              vim.diagnostic.config({
                virtual_text = not vim.diagnostic.config().virtual_text,
                virtual_lines = not vim.diagnostic.config().virtual_lines
              })
            end
          '';
        }
        {
          mode = "n";
          key = "<leader>e";
          action.__raw = ''require("mini.files").open'';
        }
      ];
    };
  };
}

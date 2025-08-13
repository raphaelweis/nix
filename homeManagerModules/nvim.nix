{ pkgs, lib, ... }:
{
  options.rw = {
    nvim.enable = lib.mkEnableOption "neovim configuration.";
  };
  config = {
    home.packages = with pkgs; [
      ripgrep
      tree-sitter

      # LSPs
      nixd
      clang-tools

      # Formatters
      nixfmt-rfc-style
    ];
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      withNodeJs = false;
      withPython3 = false;
      withRuby = false;
      plugins = with pkgs.vimPlugins; [
        vim-tmux-navigator
        nvim-treesitter.withAllGrammars
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        {
          plugin = nvim-autopairs;
          type = "lua";
          config = # lua
            ''
              require("nvim-autopairs").setup()
            '';
        }
        {
          plugin = nvim-vague;
          type = "lua";
          config = # lua
            ''
              require("vague").setup({
                transparent = false,
                italic = false,
                style = {
                  comments = "none",
                },
              })
              vim.cmd("colorscheme vague")
            '';
        }
        {
          plugin = telescope-nvim;
          type = "lua";
          config = # lua
            ''
              local builtin = require("telescope.builtin")
              vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
              vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
            '';
        }
        {
          plugin = telescope-fzf-native-nvim;
          type = "lua";
          config = # lua
            ''
              require('telescope').load_extension('fzf')
            '';
        }
        {
          plugin = nvim-treesitter;
          type = "lua";
          config = # lua
            ''
              require("nvim-treesitter.configs").setup({
                auto_install = false,
                highlight = {
                  enable = true,
                },
              })
            '';
        }
        {
          plugin = vim-fugitive;
          type = "lua";
          config = # lua
            ''
              vim.keymap.set("n", "<leader>;", "<CMD>tab Git<CR>", { desc = "Open Fugitive in a new tab" })
            '';
        }
        {
          plugin = oil-nvim;
          type = "lua";
          config = # lua
            ''
              require("oil").setup()
              vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>")
            '';
        }
        {
          plugin = nvim-cmp;
          type = "lua";
          config = # lua
            ''
              local cmp = require('cmp')
              cmp.setup({
                sources  = {
                  { name = 'nvim_lsp' },
                  { name = 'buffer' },
                  { name = 'path' },
                },
                window  = {
                  completion = cmp.config.window.bordered(),
                  documentation = cmp.config.window.bordered(),
                },
                completion = {
                  completeopt = 'menu,menuone,noinsert',
                },
                mapping = cmp.mapping.preset.insert({
                  ['<C-n>'] = cmp.mapping.select_next_item(),
                  ['<C-p>'] = cmp.mapping.select_prev_item(),
                  ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                })
              })

              local capabilities = require('cmp_nvim_lsp').default_capabilities()
              vim.lsp.config('*', {
                capabilities = capabilities,
              })
            '';
        }
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config = # lua
            ''
              vim.lsp.enable('nixd')
              vim.lsp.enable('clangd')
            '';
        }
        {
          plugin = conform-nvim;
          type = "lua";
          config = # lua
            ''
              require("conform").setup({
                formatters_by_ft = {
                  nix = { "nixfmt" },
                  c = { "clang-format" },
                  lua = { "stylua" },
                },
              })
              vim.keymap.set("n", "<leader>fm", require("conform").format, { desc = "Format current file" })
            '';
        }
      ];
      extraLuaConfig = # lua
        ''
          vim.g.mapleader = " " 
          vim.opt.number = true
          vim.opt.relativenumber = true
          vim.opt.tabstop = 2
          vim.opt.shiftwidth = 2
          vim.opt.clipboard:append("unnamedplus")
          vim.opt.swapfile = false
          vim.opt.signcolumn = "yes"
          vim.opt.winborder = "rounded"
          vim.opt.expandtab = true
          vim.opt.undofile = true

          vim.diagnostic.config({ virtual_text = true })

          vim.lsp.inlay_hint.enable(true)

          vim.keymap.set("n", "<ESC>", "<CMD>noh<CR>", { desc = "Remove highlight after search"})
          vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Go up 1 screen line" })
          vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Go down 1 screen line" }) 

          vim.keymap.set('n', 'td', function()
            local new_config = not vim.diagnostic.config().virtual_lines
            vim.diagnostic.config({ 
              virtual_lines = not vim.diagnostic.config().virtual_lines,
              virtual_text = not vim.diagnostic.config().virtual_text,
            })
          end, { desc = "Toggle diagnostic virtual lines" })
        '';
    };
  };
}

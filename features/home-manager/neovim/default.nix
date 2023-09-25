{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    extraPackages = with pkgs; [
      # lsp
      lua-language-server
      gopls
      clang-tools
      nil
      nodePackages.typescript-language-server
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vscode-css-languageserver-bin
      nodePackages.vscode-json-languageserver-bin

      # debug
      vscode-extensions.ms-vscode.cpptools
      delve

      # formatters
      nixpkgs-fmt
      nodePackages.prettier

      # else
      tree-sitter
    ];
    plugins = with pkgs.vimPlugins; [
      # plugins
      gruvbox-nvim
      plenary-nvim
      nvim-tree-lua
      vim-fugitive
      vim-tmux-navigator
      nvim-autopairs
      gitsigns-nvim
      indent-blankline-nvim
      neodev-nvim
      comment-nvim
      harpoon
      telescope-fzf-native-nvim
      telescope-nvim
      nvim-ts-autotag
      nvim-treesitter-textobjects
      nvim-treesitter
      luasnip
      cmp_luasnip
      cmp-nvim-lsp
      friendly-snippets
      nvim-cmp
      flutter-tools-nvim
      nvim-lspconfig
      nvim-dap
      nvim-dap-ui
      nvim-dap-go
      formatter-nvim
      dressing-nvim

      # treesitter parsers
      nvim-treesitter.withAllGrammars
    ];
    extraLuaConfig = ''
      local TSSERVER_PATH = "${pkgs.nodePackages.typescript-language-server}/lib/node_modules"

      ${builtins.readFile ./lua/options.lua}
      ${builtins.readFile ./lua/keymaps.lua}

      ${builtins.readFile ./lua/tree.lua}
      ${builtins.readFile ./lua/gruvbox.lua}
      ${builtins.readFile ./lua/autopairs.lua}
      ${builtins.readFile ./lua/gitsigns.lua}
      ${builtins.readFile ./lua/indent_blankline.lua}
      ${builtins.readFile ./lua/neodev.lua}
      ${builtins.readFile ./lua/comment.lua}
      ${builtins.readFile ./lua/harpoon.lua}
      ${builtins.readFile ./lua/telescope.lua}
      ${builtins.readFile ./lua/treesitter.lua}
      ${builtins.readFile ./lua/cmp.lua}
      ${builtins.readFile ./lua/lsp.lua}
      ${builtins.readFile ./lua/dap.lua}
      ${builtins.readFile ./lua/formatter.lua}

      -- Configure language servers
      lspconfig['lua_ls'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = { -- custom settings for lua
          Lua = {
            -- make the language server recognize 'vim' global
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              -- make language server aware of runtime files
              library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.stdpath('config') .. '/lua'] = true,
              },
            },
          },
        },
      })
      lspconfig['gopls'].setup({
          capabilities = capabilities,
          on_attach = on_attach,
      })
      lspconfig['clangd'].setup({
        cmd = {
          'clangd',
          '--fallback-style=Google',
        },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig['nil_ls'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ['nil'] = {
            formatting = {
              command = { 'nixpkgs-fmt' },
            },
            nix = {
              flake = {
                autoArchive = true,
              },
            },
          },
        },
      })
      lspconfig['tsserver'].setup({
        cmd = {
          TSSERVER_PATH .. "/.bin/typescript-language-server", "--stdio"
        },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig['html'].setup({
        cmd = {
          "${pkgs.nodePackages.vscode-html-languageserver-bin}/lib/node_modules/.bin/html-languageserver", "--stdio"
        },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig['cssls'].setup({
        cmd = {
          "${pkgs.nodePackages.vscode-css-languageserver-bin}/lib/node_modules/.bin/css-languageserver", "--stdio"
        },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig['jsonls'].setup({
        cmd = {
          "${pkgs.nodePackages.vscode-json-languageserver-bin}/lib/node_modules/.bin/json-languageserver", "--stdio"
        },
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- This plugin will automatically configure dartls as well
      require('flutter-tools').setup({
        widget_guides = {
          enabled = true,
        },
        lsp = {
          capabilities = capabilities,
          on_attach = on_attach
        },
        debugger = {
          enabled = true,
          run_via_dap = true,
        },
        dev_log = {
          enabled = false -- we disable this because we can see the logs in dapui
        }
      })

      -- Dap configurations that require special paths:
      -- C debugging
      local dap = require('dap')
      dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = '${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7',
      }
      dap.configurations.c = {
        {
          name = 'Launch file',
          type = 'cppdbg',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
          cwd = ''\'''${workspaceFolder}',
          stopAtEntry = true,
        },
      }
    '';
  };
}

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

      # debug
      vscode-extensions.ms-vscode.cpptools
      delve

      # formatters
      nixpkgs-fmt
    ];
    plugins = with pkgs.vimPlugins; [
      # plugins
      gruvbox-nvim
      plenary-nvim
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

      # treesitter parsers
      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-c
        p.tree-sitter-cpp
        p.tree-sitter-go
        p.tree-sitter-lua
        p.tree-sitter-python
        p.tree-sitter-rust
        p.tree-sitter-javascript
        p.tree-sitter-typescript
        p.tree-sitter-vimdoc
        p.tree-sitter-vim
        p.tree-sitter-dart
        p.tree-sitter-dockerfile
        p.tree-sitter-bash
        p.tree-sitter-json
        p.tree-sitter-yaml
        p.tree-sitter-toml
      ]))
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./lua/options.lua}
      ${builtins.readFile ./lua/keymaps.lua}

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
    '';
  };
}

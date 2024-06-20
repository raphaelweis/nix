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
        telescope = {
          enable = true;
          keymaps = { "<leader>ff" = { action = "find_files"; }; };
        };
        treesitter = { enable = true; };
				lsp = {
					enable = true;
					inlayHints = true;
					servers = {
						nixd.enable = true;		
					};
				};
        conform-nvim = {
          enable = true;
          formattersByFt = { nix = [ "nixfmt" ]; };
        };
      };
      keymaps = [
        {
          key = "<Esc>";
          action = "<CMD>noh<CR>";
        }
        {
          key = "<C-S-i>";
          action = "<CMD>lua require('conform').format()<CR>";
        }
      ];
    };
  };
}

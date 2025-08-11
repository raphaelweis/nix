{ pkgs, lib, ... }:
{
	options.rw = {
		nvim.enable = lib.mkEnableOption "neovim configuration.";
	};
	config = {
		home.packages = with pkgs; [
			ripgrep
			tree-sitter
		];
		programs.neovim = {
			enable = true;
			defaultEditor = true;
			vimAlias = true;
			withNodeJs = false;
			withPython3 = false;
			withRuby = false;
			plugins = with pkgs.vimPlugins; [
				{ 
					plugin = nvim-autopairs;
					type = "lua";
					config = ''
						require("nvim-autopairs").setup()
					'';
				}
				{
					plugin = nvim-vague;
					type = "lua";
					config = ''
						require("vague").setup({
							transparent = false
						})
						vim.cmd("colorscheme vague")
					'';
				}
				{
					plugin = telescope-nvim;
					type = "lua";
					config = ''
						local builtin = require("telescope.builtin")
						vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
						vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
					'';
				}
				{
					plugin = telescope-fzf-native-nvim;
					type = "lua";
					config = ''
						require('telescope').load_extension('fzf')
					'';
				}
				{
					plugin = nvim-treesitter;
					type = "lua";
					config = ''
						require("nvim-treesitter.configs").setup({
							auto_install = false,
							highlight = {
								enable = true,
							},
						})
					'';
				}
				nvim-treesitter.withAllGrammars
				{
					plugin = vim-fugitive;
					type = "lua";
					config = ''vim.keymap.set("n", "<leader>;", "<CMD>tab Git<CR>", { desc = "Open Fugitive in a new tab" })'';
				}
				{
					plugin = oil-nvim;
					type = "lua";
					config = ''
						require("oil").setup()
						vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>")
						'';
				}
				vim-tmux-navigator
			];
			extraLuaConfig = ''
				vim.g.mapleader = " " 
				vim.opt.number = true
				vim.opt.relativenumber = true
				vim.opt.tabstop = 4
				vim.opt.shiftwidth = 4
				vim.opt.clipboard:append("unnamedplus")
				vim.opt.swapfile = false
				vim.opt.signcolumn = "yes"

				vim.keymap.set("n", "<ESC>", "<CMD>noh<CR>", { desc = "Remove highlight after search"})
				vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Go up 1 screen line" })
				vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Go down 1 screen line" }) 
			'';
		};
	};
}


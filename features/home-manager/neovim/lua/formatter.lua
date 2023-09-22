local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		html = { require("formatter.filetypes.html").prettier },
		css = { require("formatter.filetypes.html").prettier },
		json = { require("formatter.filetypes.html").prettier },
		javascript = { require("formatter.filetypes.html").prettier },
		typescript = { require("formatter.filetypes.html").prettier },
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace
		}
	}
}

vim.api.nvim_create_autocmd('BufWritePost', {
	callback = function()
		vim.cmd('FormatWrite')
	end
})

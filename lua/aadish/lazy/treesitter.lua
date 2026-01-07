return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false, -- Plugin doesn't support lazy-loading
		build = ":TSUpdate",
		config = function()
			-- Install parsers (runs asynchronously)
			require("nvim-treesitter").install({
				"c",
				"lua",
				"html",
				"java",
				"javascript",
				"bash",
				"gitcommit",
				"diff",
				"markdown",
			})

			-- Enable highlighting via autocmd
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "c", "lua", "html", "java", "javascript", "bash", "gitcommit", "diff", "markdown" },
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
}

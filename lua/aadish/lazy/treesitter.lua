return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			local status, configs = pcall(require, "nvim-treesitter.configs")
			if not status then
				return
			end

			configs.setup({
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"html",
					"java",
					"javascript",
					"typescript",
					"tsx",
					"bash",
					"markdown",
					"markdown_inline",
					"python",
					"css",
					"json",
					"yaml",
				},
				sync_install = false,
				highlight = {
					enable = true,
					disable = {},
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				autotag = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})
		end,
	},
}

-- Typst Preview Configuration with Lazy Plugin Manager
return {
	{
		"chomosuke/typst-preview.nvim",
		version = "1.*", -- Pin to v1.* for stability
		lazy = true,
		ft = "typst", -- Load only for Typst files
		build = function()
			require("typst-preview").update()
		end,
		config = function()
			require("typst-preview").setup({
				-- Follow cursor as you type
				follow_cursor = true,
				
				-- Optional: Enable debug logging
				debug = false,
				
				-- Optional: Custom browser command
				-- open_cmd = 'firefox %s',
				
				-- Optional: Custom port (default is random)
				-- port = 8000,
				
				-- Optional: Invert colors for dark mode
				-- invert_colors = 'auto', -- 'never', 'always', or 'auto'
				
				-- Optional: Extra arguments for the previewer
				-- extra_args = { "--input=ver=draft" },
			})
		end,
		keys = {
			{ "<leader>tp", "<Cmd>TypstPreviewToggle<CR>", desc = "Toggle Typst Preview" },
			{ "<leader>to", "<Cmd>TypstPreview<CR>", desc = "Open Typst Preview" },
			{ "<leader>tc", "<Cmd>TypstPreviewStop<CR>", desc = "Close Typst Preview" },
			{ "<leader>tf", "<Cmd>TypstPreviewFollowCursorToggle<CR>", desc = "Toggle Follow Cursor" },
			{ "<leader>ts", "<Cmd>TypstPreviewSyncCursor<CR>", desc = "Sync Preview with Cursor" },
		},
	},
}

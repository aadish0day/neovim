return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "bottom",
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					hide_during_completion = false,
					debounce = 75,
					keymap = {
						accept = "<C-l>",
						accept_word = "<M-w>",
						accept_line = "<M-l>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					["*"] = true,
				},
				copilot_node_command = "node",
			})
		end,
	},
}

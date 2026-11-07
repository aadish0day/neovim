return {
	{
		"github/copilot.vim",
		init = function()
			vim.g.copilot_no_tab_map = true
		end,
		config = function()
			-- Prevent Copilot from hijacking <Tab>
			vim.g.copilot_no_tab_map = true

			-- Enable Copilot by default
			vim.g.copilot_enabled = true

			-- Define keybindings (optional)
			vim.keymap.set(
				"i",
				"<C-l>",
				'copilot#Accept("<CR>")',
				{ expr = true, silent = true, script = true, replace_keycodes = false }
			)
		end,
	},
}

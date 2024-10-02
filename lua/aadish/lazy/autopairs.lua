return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter", -- Load the plugin when entering Insert mode
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "vim" },
				check_ts = true, -- Enable treesitter integration
			})

			-- If using nvim-cmp for autocompletion, set up completion pairing
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			-- loadstring
		end,
	},
}

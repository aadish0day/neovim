return {
	{
		"echasnovski/mini.icons",
		version = "*",
		lazy = true,
		specs = {
			{ "nvim-tree/nvim-web-devicons", optional = true },
		},
		init = function()
			require("mini.icons").mock_nvim_web_devicons()
		end,
		opts = {
			file = {
				[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
			},
		},
	},
}

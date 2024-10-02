-- Plugin setup (assuming you're using packer.nvim)
return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					sh = { "shfmt" }, -- Shell script formatting with shfmt
					c = { "clang_format" }, -- C formatting with clang_format
					cpp = { "clang_format" }, -- C++ formatting with clang_format
					lua = { "stylua" }, -- Lua formatting with stylua
				},
			})
		end,
	},
}

return {
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				javascript = { "eslint_d", { "prettierd", "prettier" } },
				typescript = { "eslint_d", { "prettierd", "prettier" } },
				javascriptreact = { "eslint_d", { "prettierd", "prettier" } },
				typescriptreact = { "eslint_d", { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				yaml = { { "prettierd", "prettier" } },
				markdown = { { "prettierd", "prettier" } },
				sh = { "shfmt" },
				bash = { "shfmt" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				typst = { "typstyle" },
			},
		},
	},
}
